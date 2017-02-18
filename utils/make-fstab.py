#!/usr/bin/python3
# Script to automatically generate /etc/fstab

class Partition:
    '''
    Representation of a partition, with necessary parameters to generate an
    entry in /etc/fstab.
    '''

    def __init__(self, identifier, mount_point, partition_type, mount_options,
                 fs_checks, comments, identifier_is_uuid = True):
        if identifier_is_uuid:
            self.identifier = 'UUID=' + identifier
        else:
            self.identifier = identifier

        self.mount_point = mount_point
        self.partition_type = partition_type
        self.mount_options = mount_options
        self.fs_checks = fs_checks
        self.comments = comments

    def __repr__(self):
        return '{6:s}\n{0:46s}\t{1:24s}\t{2:13s}\t{3:18s}\t{4:2d}\t{5:2d}'\
                .format(self.identifier, self.mount_point, self.partition_type,
                        self.mount_options, self.fs_checks[0],
                        self.fs_checks[1], '# ' + self.comments)

def main():
    partitions = {
        'root': Partition('d957d314-2629-418d-b1e5-64bc78d03a64', '/' ,'ext4',
                          'errors=remount-ro', [0, 2] , 'root partition'),
        'swap': Partition('01098383-d26f-4fc3-a570-2fa65f767a0c', 'none',
                          'swap', 'sw', [0, 0], 'swap'),
        'home': Partition('176525c7-1bf1-425d-9745-e4ec860a4b0c', '/home',
                          'ext4', 'rw,exec,auto', [0, 2],
                          'linux home partition'),
        'school': Partition('012013ff-ff66-4904-92e7-7a81a30a5a2a',
                            '/home/katie/school', 'ext4', 'rw,exec,auto',
                            [0, 2], 'school partition'),
        'media': Partition('500C-AFE1', '/mnt/media', 'exfat', 'rw,exec,auto',
                           [0, 2], 'media partition'),
        'cloud': Partition('5b9cbf51-b55c-4a14-8653-2e0153a8f865',
                           '/mnt/cloud', 'ext4', 'rw,exec,auto', [0, 2],
                           'cloud partition'),
        'shared': Partition('47a4ee95-9221-4e37-850f-1c515365a3a9',
                            '/mnt/shared', 'ext4', 'rw,exec,auto', [0, 2],
                            'shared partition'),
        'matlab': Partition('ac479f9d-78d7-4066-b03a-86945c253d12',
                            '/usr/local/MATLAB/R2014b', 'ext4', 'rw,exec,auto',
                            [0, 2], 'matlab 2014b partition'),
        'matlab_2009': Partition('e2620e77-ce61-4d93-8daa-4cf41056883d',
                                 '/usr/local/MATLAB/R2009b', 'ext4',
                                 'rw,exec,auto', [0, 2],
                                 'matlab 2009b partition'),
        'boot': Partition('cdfb3a53-d96f-4ea8-98f8-2559d4ae1e88', '/boot',
                          'ext2', 'rw,auto', [0, 1], 'arch partition'),
        'backup': Partition('b60d83ea-e547-47f3-95da-7ef63bdb02c2',
                            '/mnt/backups/root', 'ext4', 'rw,noauto', [0, 0],
                            'root backup partition'),
        'backup_home': Partition('3e41cb52-f707-4186-8f68-b1a2da0d8b3f',
                                 '/mnt/backups/home', 'ext4', 'rw,noauto',
                                 [0, 0], 'home backup partition'),
        'backup_shared': Partition('65f48282-7e11-43d8-b962-dc34bd27d5be',
                                   '/mnt/backups/shared', 'ext4', 'rw,noauto',
                                   [0, 0], 'shared backup partition'),
        'backup_media': Partition('8635b56c-bdb3-4591-a4ba-efadc392e638',
                                  '/mnt/backups/media', 'ext4', 'rw,noauto',
                                  [0, 0], 'media backup partition'),
        'usb': Partition('7ECD-DEAD', '/mnt/usb', 'exfat',
                         'user,noexec,noauto', [0, 0], 'usb drive'),
        'bootloader': Partition('8352ce51-8d4a-3f7c-b93c-bd8a6c498c87',
                                '/mnt/efi', 'hfsplus', 'rw,noauto', [0, 0],
                                'linux bootloader partition'),
        'encrypted': Partition('/home/katie/.secret', '/home/katie/important',
                               'ecryptfs', 'noauto,user,rw,relatime,'
                               'ecryptfs_sig=0094cbcb775e3ea4,'
                               'ecryptfs_fnek_sig=0094cbcb775e3ea4,'
                               'ecryptfs_cipher=aes,ecryptfs_key_bytes=32,'
                               'ecryptfs_unlink_sigs', [0, 0],
                               'encrypted partition', False)

    }

    for key in partitions:
        print(partitions[key])
        print()

if __name__ == "__main__":
    main()
