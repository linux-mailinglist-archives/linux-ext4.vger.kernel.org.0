Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A943342C63
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Mar 2021 12:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhCTLlf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 20 Mar 2021 07:41:35 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49165 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCTLlI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 20 Mar 2021 07:41:08 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 12KA2FN2030907;
        Sat, 20 Mar 2021 19:02:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp);
 Sat, 20 Mar 2021 19:02:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 12KA2Elv030897
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 20 Mar 2021 19:02:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: possible deadlock in start_this_handle (2)
To:     Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, mhocko@suse.cz, linux-mm@kvack.org,
        syzbot <syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>
References: <000000000000563a0205bafb7970@google.com>
 <20210211104947.GL19070@quack2.suse.cz>
 <bf1088e3-b051-6361-57dd-6b836b1c3b46@i-love.sakura.ne.jp>
 <20210215124519.GA22417@quack2.suse.cz>
 <aaee5d61-f988-84c3-4d16-f8b7987f3a83@i-love.sakura.ne.jp>
 <20210215142935.GB22417@quack2.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <65d305ad-cb5f-a7df-9385-500d2a5a7ac9@i-love.sakura.ne.jp>
Date:   Sat, 20 Mar 2021 19:02:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210215142935.GB22417@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Peter, would you answer to 6 questions listed below?

Below is a reproducer kernel module (prefixed with "my_" for distinction) for
https://syzkaller.appspot.com/bug?id=38c060d5757cbc13fdffd46e80557c645fbe79ba .

---------- test.c ----------
#include <linux/module.h>
#include <linux/jbd2.h>
#include <../fs/ext4/ext4.h>

static struct lockdep_map my__fs_reclaim_map = STATIC_LOCKDEP_MAP_INIT("my_fs_reclaim", &my__fs_reclaim_map);

static noinline void my_journal_init_common(journal_t *journal)
{
        static struct lock_class_key my_jbd2_trans_commit_key;

        lockdep_init_map(&journal->j_trans_commit_map, "my_jbd2_handle", &my_jbd2_trans_commit_key, 0);
}

static noinline void my_init_once(void *foo)
{
        struct ext4_inode_info *my_ei = (struct ext4_inode_info *) foo;

        init_rwsem(&my_ei->xattr_sem);
}

static int __init lockdep_test_init(void)
{
        journal_t *journal1 = kzalloc(sizeof(*journal1), GFP_KERNEL | __GFP_NOFAIL);
        struct ext4_inode_info *ei1 = kzalloc(sizeof(*ei1), GFP_KERNEL | __GFP_NOFAIL);
        struct ext4_inode_info *ei2 = kzalloc(sizeof(*ei2), GFP_KERNEL | __GFP_NOFAIL);

        my_journal_init_common(journal1);
        my_init_once(ei1);
        my_init_once(ei2);

        rwsem_acquire_read(&journal1->j_trans_commit_map, 0, 0, _THIS_IP_);
        down_write(&ei1->xattr_sem);
        up_write(&ei1->xattr_sem);
        rwsem_release(&journal1->j_trans_commit_map, _THIS_IP_);

        down_write(&ei2->xattr_sem);
        lock_map_acquire(&my__fs_reclaim_map);
        lock_map_release(&my__fs_reclaim_map);
        up_write(&ei2->xattr_sem);

        lock_map_acquire(&my__fs_reclaim_map);
        rwsem_acquire_read(&journal1->j_trans_commit_map, 0, 0, _THIS_IP_);
        rwsem_release(&journal1->j_trans_commit_map, _THIS_IP_);
        lock_map_release(&my__fs_reclaim_map);

        return -EINVAL;
}

module_init(lockdep_test_init);
MODULE_LICENSE("GPL");
---------- test.c ----------

---------- dmesg ----------
[   32.938906][ T2776] test: loading out-of-tree module taints kernel.
[   32.940200][ T2776]
[   32.940240][ T2776] ======================================================
[   32.940306][ T2776] WARNING: possible circular locking dependency detected
[   32.940373][ T2776] 5.12.0-rc3+ #846 Tainted: G           O
[   32.940434][ T2776] ------------------------------------------------------
[   32.940500][ T2776] insmod/2776 is trying to acquire lock:
[   32.940557][ T2776] ffff9f1d438d98e0 (my_jbd2_handle){.+.+}-{0:0}, at: lockdep_test_init+0x0/0x1000 [test]
[   32.940651][ T2776]
[   32.940651][ T2776] but task is already holding lock:
[   32.940719][ T2776] ffffffffc0631020 (my_fs_reclaim){+.+.}-{0:0}, at: lockdep_test_init+0x0/0x1000 [test]
[   32.940808][ T2776]
[   32.940808][ T2776] which lock already depends on the new lock.
[   32.940808][ T2776]
[   32.940897][ T2776]
[   32.940897][ T2776] the existing dependency chain (in reverse order) is:
[   32.940976][ T2776]
[   32.940976][ T2776] -> #2 (my_fs_reclaim){+.+.}-{0:0}:
[   32.941053][ T2776]        lock_acquire+0xb3/0x380
[   32.941112][ T2776]        lockdep_test_init+0xe2/0x1000 [test]
[   32.941176][ T2776]        do_one_initcall+0x58/0x2c0
[   32.941234][ T2776]        do_init_module+0x5b/0x210
[   32.941291][ T2776]        load_module+0x1884/0x19a0
[   32.941347][ T2776]        __do_sys_finit_module+0xc1/0x120
[   32.941408][ T2776]        __x64_sys_finit_module+0x15/0x20
[   32.941469][ T2776]        do_syscall_64+0x31/0x40
[   32.941527][ T2776]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   32.941594][ T2776]
[   32.941594][ T2776] -> #1 (&my_ei->xattr_sem){+.+.}-{3:3}:
[   32.941673][ T2776]        lock_acquire+0xb3/0x380
[   32.941728][ T2776]        down_write+0x52/0x620
[   32.941783][ T2776]        lockdep_test_init+0xa2/0x1000 [test]
[   32.941846][ T2776]        do_one_initcall+0x58/0x2c0
[   32.941904][ T2776]        do_init_module+0x5b/0x210
[   32.941960][ T2776]        load_module+0x1884/0x19a0
[   32.942016][ T2776]        __do_sys_finit_module+0xc1/0x120
[   32.942077][ T2776]        __x64_sys_finit_module+0x15/0x20
[   32.942137][ T2776]        do_syscall_64+0x31/0x40
[   32.942193][ T2776]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   32.942260][ T2776]
[   32.942260][ T2776] -> #0 (my_jbd2_handle){.+.+}-{0:0}:
[   32.942336][ T2776]        check_prevs_add+0x16a/0x1040
[   32.942395][ T2776]        __lock_acquire+0x118b/0x1580
[   32.942453][ T2776]        lock_acquire+0xb3/0x380
[   32.942509][ T2776]        lockdep_test_init+0x140/0x1000 [test]
[   32.942574][ T2776]        do_one_initcall+0x58/0x2c0
[   32.942631][ T2776]        do_init_module+0x5b/0x210
[   32.942687][ T2776]        load_module+0x1884/0x19a0
[   32.942743][ T2776]        __do_sys_finit_module+0xc1/0x120
[   32.942803][ T2776]        __x64_sys_finit_module+0x15/0x20
[   32.942915][ T2776]        do_syscall_64+0x31/0x40
[   32.942973][ T2776]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   32.943041][ T2776]
[   32.943041][ T2776] other info that might help us debug this:
[   32.943041][ T2776]
[   32.943138][ T2776] Chain exists of:
[   32.943138][ T2776]   my_jbd2_handle --> &my_ei->xattr_sem --> my_fs_reclaim
[   32.943138][ T2776]
[   32.943258][ T2776]  Possible unsafe locking scenario:
[   32.943258][ T2776]
[   32.943333][ T2776]        CPU0                    CPU1
[   32.943392][ T2776]        ----                    ----
[   32.943449][ T2776]   lock(my_fs_reclaim);
[   32.943500][ T2776]                                lock(&my_ei->xattr_sem);
[   32.943572][ T2776]                                lock(my_fs_reclaim);
[   32.943641][ T2776]   lock(my_jbd2_handle);
[   32.943693][ T2776]
[   32.943693][ T2776]  *** DEADLOCK ***
[   32.943693][ T2776]
[   32.943775][ T2776] 1 lock held by insmod/2776:
[   32.943829][ T2776]  #0: ffffffffc0631020 (my_fs_reclaim){+.+.}-{0:0}, at: lockdep_test_init+0x0/0x1000 [test]
[   32.943931][ T2776]
[   32.943931][ T2776] stack backtrace:
[   32.943996][ T2776] CPU: 0 PID: 2776 Comm: insmod Tainted: G           O      5.12.0-rc3+ #846
[   32.944084][ T2776] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   32.944246][ T2776] Call Trace:
[   32.944292][ T2776]  dump_stack+0x76/0x95
[   32.944376][ T2776]  print_circular_bug.isra.49.cold.70+0x13c/0x141
[   32.944446][ T2776]  check_noncircular+0xfe/0x110
[   32.944504][ T2776]  check_prevs_add+0x16a/0x1040
[   32.944561][ T2776]  __lock_acquire+0x118b/0x1580
[   32.944658][ T2776]  ? lock_is_held_type+0x97/0x100
[   32.944717][ T2776]  lock_acquire+0xb3/0x380
[   32.944771][ T2776]  ? 0xffffffffc0273000
[   32.944822][ T2776]  ? lock_release+0xb8/0x270
[   32.944877][ T2776]  lockdep_test_init+0x140/0x1000 [test]
[   32.944939][ T2776]  ? 0xffffffffc0273000
[   32.944989][ T2776]  ? 0xffffffffc0273000
[   32.945039][ T2776]  do_one_initcall+0x58/0x2c0
[   32.945094][ T2776]  ? kmem_cache_alloc_trace+0x745/0x820
[   32.945157][ T2776]  ? do_init_module+0x22/0x210
[   32.945212][ T2776]  do_init_module+0x5b/0x210
[   32.945267][ T2776]  load_module+0x1884/0x19a0
[   32.945324][ T2776]  __do_sys_finit_module+0xc1/0x120
[   32.945382][ T2776]  ? __do_sys_finit_module+0xc1/0x120
[   32.945444][ T2776]  __x64_sys_finit_module+0x15/0x20
[   32.945502][ T2776]  do_syscall_64+0x31/0x40
[   32.945555][ T2776]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   32.945619][ T2776] RIP: 0033:0x7fa7bb256d19
[   32.945672][ T2776] Code: 01 00 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 e1 2c 00 f7 d8 64 89 01 48
[   32.945842][ T2776] RSP: 002b:00007ffd756468e8 EFLAGS: 00000206 ORIG_RAX: 0000000000000139
[   32.945927][ T2776] RAX: ffffffffffffffda RBX: 0000000000c2f250 RCX: 00007fa7bb256d19
[   32.946007][ T2776] RDX: 0000000000000000 RSI: 000000000041a96e RDI: 0000000000000003
[   32.946088][ T2776] RBP: 000000000041a96e R08: 0000000000000000 R09: 00007ffd75646a88
[   32.946168][ T2776] R10: 0000000000000003 R11: 0000000000000206 R12: 0000000000000000
[   32.946248][ T2776] R13: 0000000000c2f220 R14: 0000000000000000 R15: 0000000000000000
---------- dmesg ----------



Q1:

mm/page_alloc.c defines __fs_reclaim_map as

  static struct lockdep_map __fs_reclaim_map = STATIC_LOCKDEP_MAP_INIT("fs_reclaim", &__fs_reclaim_map);

where STATIC_LOCKDEP_MAP_INIT(_name, _key) is defined by include/linux/lockdep.h as

  #define STATIC_LOCKDEP_MAP_INIT(_name, _key) { .name = (_name), .key = (void *)(_key), }

which results in

  static struct lockdep_map __fs_reclaim_map = { .name = "fs_reclaim", .key = &__fs_reclaim_map };

indicating that there is only one instance of "struct lockdep_map" and one constant value for "struct lockdep_map"->key .
Is my understanding correct?



Q2:

journal_init_common() in fs/jbd2/journal.c defines jbd2_trans_commit_key as

  static struct lock_class_key jbd2_trans_commit_key;

and journal_init_common() is passing this constant value for "struct lockdep_map"->key to
all instances of "struct lockdep_map" via

  lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle", &jbd2_trans_commit_key, 0) {
    lockdep_init_map_wait(&journal->j_trans_commit_map, "jbd2_handle", &jbd2_trans_commit_key, 0, LD_WAIT_INV) {
      lockdep_init_map_waits(&journal->j_trans_commit_map, "jbd2_handle", &jbd2_trans_commit_key, 0, LD_WAIT_INV, LD_WAIT_INV) {
        lockdep_init_map_type(&journal->j_trans_commit_map, "jbd2_handle", &jbd2_trans_commit_key, 0, 0, 0) {
          journal->j_trans_commit_map.name = "jbd2_handle";
          journal->j_trans_commit_map.key = &jbd2_trans_commit_key;
        }
      }
    }
  }

on each journal, indicating that there can be multiple instances of "struct lockdep_map"
but every instance shares one constant value for that "struct lockdep_map"->key .
Is my understanding correct?



Q3:

init_once() in fs/ext4/super.c initializes ei->xattr_sem on each inode via

  init_rwsem(&ei->xattr_sem);

where init_rwsem() is defined in include/linux/rwsem.h as

  #define init_rwsem(sem)                   \
  do {                                      \
  	static struct lock_class_key __key; \
  					    \
  	__init_rwsem((sem), #sem, &__key);  \
  } while (0)

and __init_rwsem() in kernel/locking/rwsem.c does

  lockdep_init_map_wait(&ei->xattr_sem.dep_map, "&ei->xattr_sem", &__key, 0, LD_WAIT_SLEEP);
    lockdep_init_map_waits(&ei->xattr_sem.dep_map, "&ei->xattr_sem", &__key, 0, LD_WAIT_SLEEP, LD_WAIT_INV) {
      lockdep_init_map_type(&ei->xattr_sem.dep_map, "&ei->xattr_sem", &__key, 0, LD_WAIT_SLEEP, 0) {
        ei->xattr_sem.dep_map.name = "&ei->xattr_sem";
        ei->xattr_sem.dep_map.key = &__key;
      }
    }
  }

on each inode, indicating that there can be multiple instances of "struct lockdep_map"
but every instance shares one constant value for that "struct lockdep_map"->key .
Is my understanding correct?



Q4:

check_prev_add() in kernel/locking/lockdep.c checks possibility of
deadlock from "struct lock_class lock_classes[MAX_LOCKDEP_KEYS]" rather
than individual "struct lockdep_map" instance. Is this correct?



Q5:

Due to not using individual "struct lockdep_map" instance for checking
possibility of deadlock, despite there can be multiple
"journal->j_trans_commit_map" instances and multiple
"ei->xattr_sem" instances, lockdep treats "journal->j_trans_commit_map"
and "ei->xattr_sem.dep_map" and __fs_reclaim_map equally (in other words,
lockdep thinks as if there is only one instance of
"journal->j_trans_commit_map" and "ei->xattr_sem.dep_map" and __fs_reclaim_map).
Is this correct?



Q6:

If 5 questions listed above are "yes", then,

  Chain exists of:
    jbd2_handle --> &ei->xattr_sem --> fs_reclaim
  
   Possible unsafe locking scenario:
  
         CPU0                    CPU1
         ----                    ----
    lock(fs_reclaim);
                                 lock(&ei->xattr_sem);
                                 lock(fs_reclaim);
    lock(jbd2_handle);

is simplified as if

  Chain exists of:
    jbd2_handle --> ei_xattr_sem --> fs_reclaim
  
   Possible unsafe locking scenario:
  
         CPU0                    CPU1
         ----                    ----
    lock(fs_reclaim);
                                 lock(ei_xattr_sem);
                                 lock(fs_reclaim);
    lock(jbd2_handle);

. Is this correct?



If 6 questions listed above are "yes", Jan Kara's response that

  *but*
  
  b) as I wrote in the email you are replying to, the jbd2_handle key is
  private per filesystem. Thus for lockdep to complain about
  jbd2_handle->fs_reclaim->jbd2_handle deadlock, those jbd2_handle lockdep
  maps must come from the same filesystem.
  
  *and*
  
  c) filesystem without journal doesn't use jbd2_handle lockdep map at all so
  for such filesystems lockdep creates no dependency for jbd2_handle map.

will not help avoiding this lockdep report because

  a) I think that syzbot reboots the VM between executing different tests to
  get reproducible conditions. But in theory I agree the test may have
  contained one image with and one image without a journal.

can become true beause syzkaller can test both "filesystem without journal" and
"filesystem with journal" within single boot, and same ei->xattr_sem.dep_map is
used for both "filesystem without journal" and "filesystem with journal"...

