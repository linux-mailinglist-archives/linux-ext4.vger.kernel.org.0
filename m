Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEE437F52A
	for <lists+linux-ext4@lfdr.de>; Thu, 13 May 2021 12:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhEMKBt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 May 2021 06:01:49 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:26872 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbhEMKBr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 May 2021 06:01:47 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210513100036epoutp047d10f07c5d20d1d723bf925eeef48be4~_l-6_ycxR3066530665epoutp049
        for <linux-ext4@vger.kernel.org>; Thu, 13 May 2021 10:00:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210513100036epoutp047d10f07c5d20d1d723bf925eeef48be4~_l-6_ycxR3066530665epoutp049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1620900036;
        bh=Br2S5X1A3eYkSt6sVY9ESm35W/Sdx9AnQBvvS1O7OOM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tzwfth3DujOdfD+2en8SiEdCnojJKnq5DVrIAHe8QLT420knCdb0b/t3nFnC8LKn4
         zQIG5Z39gjXoUvQhJ6Wrbk1wl+w1htHzyIjurGN06cS5RJsqpXtmnxjB96RZADQDeK
         6GYfPF1pY4GjQxpwX73dk6iaVBL654zOoVpKLM50=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210513100035epcas1p4ed4d387b03b4a842ee4dc632eca2f2ba~_l-6f8fPN2326223262epcas1p4I;
        Thu, 13 May 2021 10:00:35 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.161]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FgnGV54gPz4x9QD; Thu, 13 May
        2021 10:00:34 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.2C.09578.2C8FC906; Thu, 13 May 2021 19:00:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210513100034epcas1p4b23892cd77bde73c777eea6dc51c16a4~_l-46m7KD2326223262epcas1p4D;
        Thu, 13 May 2021 10:00:34 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210513100034epsmtrp14ca69c66797fa911302550f7051b0cf8~_l-44-Fm32978629786epsmtrp1P;
        Thu, 13 May 2021 10:00:34 +0000 (GMT)
X-AuditID: b6c32a35-58cdfa800000256a-14-609cf8c20f50
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.13.08163.1C8FC906; Thu, 13 May 2021 19:00:33 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210513100033epsmtip1a821dbd3078b7503fe8e1e6cb900172b~_l-4ojBIa0851508515epsmtip1n;
        Thu, 13 May 2021 10:00:33 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     alex_y_xu@yahoo.ca
Cc:     axboe@kernel.dk, bgoncalv@redhat.com, bvanassche@acm.org,
        dm-crypt@saout.de, hch@lst.de, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        ming.lei@redhat.com, yi.zhang@redhat.com
Subject: Re: regression: data corruption with ext4 on LUKS on nvme with
 torvalds master
Date:   Thu, 13 May 2021 18:42:22 +0900
Message-Id: <20210513094222.17635-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmge6hH3MSDD48U7ZYd2cNu8Xqu/1s
        Frsuzme0mPbhJ7PF7eZfbBYrVx9lsniyfhazxd5b2hYz591hs7i8aw6bxfxlT9ktDk1uZrK4
        fm4amwOvx+Ur3h6Xz5Z6bFrVyeaxeUm9x+6bDWwe7/ddZfM4s+c4k8fnTXIehw4tYw7gjMqx
        yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6WkmhLDGn
        FCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhQoFecmFtcmpeul5yfa2VoYGBkClSZkJPx
        pvMYc0GHRkXvr0NMDYzTFboYOTkkBEwk+s8eYeli5OIQEtjBKHHnyElmCOcTo8ThZS1sEM5n
        Romuvw3sMC3nGt9DtexilFh/bik7XNXVsxsYQarYBHQk+t7eYgOxRQTEJH7O/wnWwSwwg0ni
        xZOTQAkODmGBSIn5rQIgNSwCqhLPFp9jBQnzClhLTL0aCbFMXuLP/R5mEJtXQFDi5MwnLCA2
        M1C8eetsZoiamRwSTw/qQ9guEk8//GeDsIUlXh3fAnW0lMTL/jawOyUEuhklmtvmM0I4Exgl
        ljxfxgRRZSzx6fNnRpAjmAU0JdbvghqqKLHz91xGiMV8Eu++9oDdKSHAK9HRJgRRoiJxpuU+
        M8yu52t3Qk30kDj2cwuYLSQQK7Fs907WCYzys5C8MwvJO7MQFi9gZF7FKJZaUJybnlpsWGCI
        HKubGMEpV8t0B+PEtx/0DjEycTAeYpTgYFYS4RVLmp0gxJuSWFmVWpQfX1Sak1p8iNEUGL4T
        maVEk/OBST+vJN7Q1MjY2NjCxMzczNRYSZw33bk6QUggPbEkNTs1tSC1CKaPiYNTqoHpeI/G
        n1drnXy/ZOvU91QcMHF+Mi0k4PrNRzxli9K/NGak3cx7KKGZVdhxRMld9IfWmdqjHdzqnRn3
        5/7J2fjfW0b1z90b1ZuT96TcX7zJzeia8T07j9NzDsXo3PtRv+z2OqaQWX6vFkYUpn+ccjDL
        XvmH+fRsoV9LSqsyf6iW5ab6nzjcaZHY5Tp73aTU2gpW5o6wza9nPcn58IpHl3nlUolrPZr/
        S95uPMxg6Z7M6l3zTF+pb8OxhW/FW4rr7nj2+tV66R5fPPPip/7rUS3uB95+n+cvPbO4xXtz
        8JKjrBnFBv+snbWWP9i4Md7l5c1zz6b21l41f+S9SzCoQiH98BvhLoV1qa7pIVE6ZqpKLMUZ
        iYZazEXFiQB0K1/XQgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSnO7BH3MSDA5tMbVYd2cNu8Xqu/1s
        Frsuzme0mPbhJ7PF7eZfbBYrVx9lsniyfhazxd5b2hYz591hs7i8aw6bxfxlT9ktDk1uZrK4
        fm4amwOvx+Ur3h6Xz5Z6bFrVyeaxeUm9x+6bDWwe7/ddZfM4s+c4k8fnTXIehw4tYw7gjOKy
        SUnNySxLLdK3S+DKeNN5jLmgQ6Oi99chpgbG6QpdjJwcEgImEuca37OA2EICOxgldjaaQ8Sl
        JI6feMvaxcgBZAtLHD5c3MXIBVTykVHi3967TCA1bAI6En1vb7GB2CICYhI/5/9kASliFljG
        JPHmH4jDwSEsEC7RdN0JpIZFQFXi2eJzYDN5Bawlpl6NhFglL/Hnfg8ziM0rIChxcuYTsHOY
        geLNW2czT2Dkm4UkNQtJagEj0ypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjODg19La
        wbhn1Qe9Q4xMHIyHGCU4mJVEeMWSZicI8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9
        sSQ1OzW1ILUIJsvEwSnVwKR0kvF/0iH7A/671wppPfXNmi5a1pVw7F5AzJUSiWl7w1e8Cir0
        +l3O8bXjsoHTaaVPJh8WuKvLvD6tNMPx01Y9zbN7Oi14Zh2af9Al5WbDpBzuGx9YZyz7ET/L
        12Z30Y4pblK1j9wFmhLub2NQ/9F/+9dels6NoYsbbq1ef/xV74KnhtPi3CoUL0RccGULLOBi
        /xBx5mPq9YwFG4tCb3Re2iE/+znvsncTz+fdvvAj/t7hPrlz3TIfuhYdbv+3SuGC/6GFCyxq
        6nev59m67dWxF5d32T/PWhnke19D+yLDcYbUCxtjSpcWGRve0LLbYrBVLqv04oJsnkTRvvfh
        DgvlWzTj5gUeDp++SzLrjuRfJZbijERDLeai4kQAfwrD6+0CAAA=
X-CMS-MailID: 20210513100034epcas1p4b23892cd77bde73c777eea6dc51c16a4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210513100034epcas1p4b23892cd77bde73c777eea6dc51c16a4
References: <CGME20210513100034epcas1p4b23892cd77bde73c777eea6dc51c16a4@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> Excerpts from Jens Axboe's message of May 8, 2021 11:51 pm:
> > On 5/8/21 8:29 PM, Alex Xu (Hello71) wrote:
> >> Excerpts from Alex Xu (Hello71)'s message of May 8, 2021 1:54 pm:
> >>> Hi all,
> >>>
> >>> Using torvalds master, I recently encountered data corruption on my ext4 
> >>> volume on LUKS on NVMe. Specifically, during heavy writes, the system 
> >>> partially hangs; SysRq-W shows that processes are blocked in the kernel 
> >>> on I/O. After forcibly rebooting, chunks of files are replaced with 
> >>> other, unrelated data. I'm not sure exactly what the data is; some of it 
> >>> is unknown binary data, but in at least one case, a list of file paths 
> >>> was inserted into a file, indicating that the data is misdirected after 
> >>> encryption.
> >>>
> >>> This issue appears to affect files receiving writes in the temporal 
> >>> vicinity of the hang, but affects both new and old data: for example, my 
> >>> shell history file was corrupted up to many months before.
> >>>
> >>> The drive reports no SMART issues.
> >>>
> >>> I believe this is a regression in the kernel related to something merged 
> >>> in the last few days, as it consistently occurs with my most recent 
> >>> kernel versions, but disappears when reverting to an older kernel.
> >>>
> >>> I haven't investigated further, such as by bisecting. I hope this is 
> >>> sufficient information to give someone a lead on the issue, and if it is 
> >>> a bug, nail it down before anybody else loses data.
> >>>
> >>> Regards,
> >>> Alex.
> >>>
> >> 
> >> I found the following test to reproduce a hang, which I guess may be the 
> >> cause:
> >> 
> >> host$ cd /tmp
> >> host$ truncate -s 10G drive
> >> host$ qemu-system-x86_64 -drive format=raw,file=drive,if=none,id=drive -device nvme,drive=drive,serial=1 [... more VM setup options]
> >> guest$ cryptsetup luksFormat /dev/nvme0n1
> >> [accept warning, use any password]
> >> guest$ cryptsetup open /dev/nvme0n1
> >> [enter password]
> >> guest$ mkfs.ext4 /dev/mapper/test
> >> [normal output...]
> >> Creating journal (16384 blocks): [hangs forever]
> >> 
> >> I bisected this issue to:
> >> 
> >> cd2c7545ae1beac3b6aae033c7f31193b3255946 is the first bad commit
> >> commit cd2c7545ae1beac3b6aae033c7f31193b3255946
> >> Author: Changheun Lee <nanich.lee@samsung.com>
> >> Date:   Mon May 3 18:52:03 2021 +0900
> >> 
> >>     bio: limit bio max size
> >> 
> >> I didn't try reverting this commit or further reducing the test case. 
> >> Let me know if you need my kernel config or other information.
> > 
> > If you have time, please do test with that reverted. I'd be anxious to
> > get this revert queued up for 5.13-rc1.
> > 
> > -- 
> > Jens Axboe
> > 
> > 
> 
> I tested reverting it on top of b741596468b010af2846b75f5e75a842ce344a6e 
> ("Merge tag 'riscv-for-linus-5.13-mw1' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux"), causing it 
> to no longer hang. I didn't check if this fixes the data corruption, but 
> I assume so.
> 
> I also tested a 1 GB image (works either way), and a virtio-blk 
> interface (works either way)
> 
> The Show Blocked State from the VM (without revert):
> 
> sysrq: Show Blocked State
> task:kworker/u2:0    state:D stack:    0 pid:    7 ppid:     2 flags:0x00004000
> Workqueue: kcryptd/252:0 kcryptd_crypt
> Call Trace:
> __schedule+0x1a2/0x4f0
> schedule+0x63/0xe0
> schedule_timeout+0x6a/0xd0
> ? lock_timer_base+0x80/0x80
> io_schedule_timeout+0x4c/0x70
> mempool_alloc+0xfc/0x130
> ? __wake_up_common_lock+0x90/0x90
> kcryptd_crypt+0x291/0x4e0
> process_one_work+0x1b1/0x300
> worker_thread+0x48/0x3d0
> ? process_one_work+0x300/0x300
> kthread+0x129/0x150
> ? __kthread_create_worker+0x100/0x100
> ret_from_fork+0x22/0x30
> task:mkfs.ext4       state:D stack:    0 pid:  979 ppid:   964 flags:0x00004000
> Call Trace:
> __schedule+0x1a2/0x4f0
> ? __schedule+0x1aa/0x4f0
> schedule+0x63/0xe0
> schedule_timeout+0x99/0xd0
> io_schedule_timeout+0x4c/0x70
> wait_for_completion_io+0x74/0xc0
> submit_bio_wait+0x46/0x60
> blkdev_issue_zeroout+0x118/0x1f0
> blkdev_fallocate+0x125/0x180
> vfs_fallocate+0x126/0x2e0
> __x64_sys_fallocate+0x37/0x60
> do_syscall_64+0x61/0x80
> ? do_syscall_64+0x6e/0x80
> entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Regards,
> Alex.
> 

First of all, thank you very much for report a bug. And sorry about your
data lose.

Problem might be casued by exhausting of memory. And memory exhausting
would be caused by setting of small bio_max_size. Actually it was not
reproduced in my VM environment at first. But, I reproduced same problem
when bio_max_size is set with 8KB forced. Too many bio allocation would
be occurred by setting of 8KB bio_max_size.

So I prepare v10 patch to fix this bug. It will prevent that bio_max_size
is set with small size. bio_max_size will be set with 1MB as a minimum.
This size is same with legacy bio size before applying of "multipage bvec".

It will be very helpful to me If you test with v10 patch. :)

Thanks,
Changheun Lee.
