__author__ = 'cesc'

# please update the following information if necessary

aws_access_key_id = "AKIAIEFSDMMT4FWVDXJQ"
aws_secret_access_key = "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"
singapore_region = "ap-southeast-1"
ami_id = "ami-cae8b498"
aws_key = "mark_splk"
security_group = "qlm_mark_systest"

# system environment scope
master = 1
deployment_server = 1
slave = 3
search_head = 1
license_master = 1
forwarder = 1

# instance_name
prefix = "QLM_SPLK"

# check_ssh
pem_file_path = '/Users/cesc/Work/Documents/AWSkeys/mark_splk.pem'
ssh_username = 'ubuntu'

# aws_machine_file path
output_path = "aws_instance_list"

import sys, os
import time
from boto import ec2
from fabric.api import env, run


def create_instance(instance_type, instance_name):
    conn = ec2.connect_to_region(singapore_region,
                                 aws_access_key_id=aws_access_key_id,
                                 aws_secret_access_key=aws_secret_access_key)
    reservations = conn.run_instances(
        ami_id,
        key_name=aws_key,
        instance_type='m3.xlarge',
        security_groups=[security_group])

    instance = reservations.instances[0]
    status = instance.update()
    while status == 'pending':
        time.sleep(1)
        status = instance.update()

    if status == 'running':
        instance.add_tag("Name", instance_name)

    return (instance, instance_type, instance_name)


def test_ssh(instance_tuple, f):
    _aws_instance = instance_tuple[0]
    env.host_string = _aws_instance.public_dns_name
    env.user = ssh_username
    env.key_filename = pem_file_path

    start_time = time.time()
    while (time.time() - start_time) < 5 * 60:
        try:
            run("/usr/bin/whoami")
            f.write("%s,%s,%s" % (_aws_instance.id, _aws_instance.public_dns_name, instance_tuple[1]))
            break
        except:
            time.sleep(10)


def main():
    if os.path.exists(output_path):
        os.remove(output_path)

    f = open(output_path, "w")
    aws_instances = []
    conn = ec2.connect_to_region(singapore_region,
                                 aws_access_key_id=aws_access_key_id,
                                 aws_secret_access_key=aws_secret_access_key)

    try:
        # first create the instance in aws
        sys.stdout.write(
            "The environment need total %s machines\n" % (
                master + search_head + peer + forwarder + license_master + deployment_server))

        sys.stdout.write("create the instance as master\n")
        for i in range(master):
            instance_name = "%s_%s_%s" % (prefix, "master", i)
            sys.stdout.write("[%s] create the master with name #%s#\n" % ("master", instance_name))
            aws_instances.append(create_instance("master", instance_name))

        sys.stdout.write("create the instance as slave\n")
        for i in range(slave):
            instance_name = "%s_%s_%s" % (prefix, "slave", i)
            sys.stdout.write("[%s] create the slave with name #%s#\n" % ("slave", instance_name))
            aws_instances.append(create_instance("slave", instance_name))

        sys.stdout.write("create the instance as searchHead\n")
        for i in range(search_head):
            instance_name = "%s_%s_%s" % (prefix, "searchHead", i)
            sys.stdout.write("[%s] create the searchHead with name #%s#\n" % ("searchHead", instance_name))
            aws_instances.append(create_instance("searchHead", instance_name))

        sys.stdout.write("create the instance as deploymentServer\n")
        for i in range(deployment_server):
            instance_name = "%s_%s_%s" % (prefix, "deploymentServer", i)
            sys.stdout.write("[%s] create the deploymentServer with name #%s#\n" % ("deploymentServer", instance_name))
            aws_instances.append(create_instance("deploymentServer", instance_name))

        sys.stdout.write("create the instance as forwarder\n")
        for i in range(forwarder):
            instance_name = "%s_%s_%s" % (prefix, "forwarder", i)
            sys.stdout.write("[%s] create the forwarder with name #%s#\n" % ("forwarder", instance_name))
            aws_instances.append(create_instance("forwarder", instance_name))

        sys.stdout.write("create the instance as licenseMaster\n")
        for i in range(license_master):
            instance_name = "%s_%s_%s" % (prefix, "licenseMaster", i)
            sys.stdout.write("[%s] create the licenseMaster with name #%s#\n" % ("licenseMaster", instance_name))
            aws_instances.append(create_instance("licenseMaster", instance_name))

        # check the ssh available
        for instance in aws_instances:
            test_ssh(instance, f)

    except Exception, e:
        sys.stderr.write("[Error] %s" % str(e))
    finally:
        f.close()


if __name__ == "__main__":
    try:
        main()
    except Exception, e:
        sys.stderr.write(str(e))