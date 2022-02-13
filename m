Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C5F4B3CB6
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Feb 2022 19:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiBMSDs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 13 Feb 2022 13:03:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiBMSDs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 13 Feb 2022 13:03:48 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575225A5AB;
        Sun, 13 Feb 2022 10:03:42 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id t4-20020a17090a510400b001b8c4a6cd5dso13597765pjh.5;
        Sun, 13 Feb 2022 10:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to;
        bh=DYwaU/Q5WyrKiRKoqCGyqe8F/8o+lZmqqLGmDWVpM4M=;
        b=WGb2IJjvRXGCGSf23wb/hKlVOzS2B1fbjdpoNoqy/LPOMXshL6rM5Tb2p3RUQ45WER
         GsVLMiJ2lWWi/fNp3MLObQrDujt1iuq1TVDPw933iHpI9bznHwcoWE5edDF8z9lf8ErZ
         bEeURiTb2sVDSj+AqqbNk4VL4jndj1s3EBueycQi3xHU7CRMC34ZlqCdF89+YBzGRwro
         pg+uOmglohqFXsxGUlV82JliFRoX/H6eu/Bg/FbT0F5HMo1UADOPfSGJdmdfF0FTeNlw
         iI9WH8XahqVZSIe2f3nGnoRRPm+qKXQqswd8USle9+9YR9IWcjJkC1o6c0/mK/p71SyI
         UOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to;
        bh=DYwaU/Q5WyrKiRKoqCGyqe8F/8o+lZmqqLGmDWVpM4M=;
        b=fmn3vvfF43N6lfyEXZveWzEhqpgUpnb4e2AdRLkcFevd8NGO7hHsYA3jLTWYyIsOtN
         hbfn60QrgEN46MGnLt3D8lWb7oFu1eihGmjUALYVxwgbmvQbjUFJqulDpPF95HhILnxa
         HJbAYBlc7JOGpo4aTWEt4lrHR3PbFFwqTYqkKJkaD0YKcurYFsGJ9pIrVvBej3z0SNLi
         uINVei+1F6hcWpW3zsIhc88A5Mp4AHAEx9SBrPQuoRY8CbEbk0TKdw7BNyRbhxBV8/0L
         u4W9dq+npXHNslJNsNibUmtAkT1UxuBtUjX9UUZRpLOFukgzxm3k3yhjAcLjbi1awJPo
         6Hsw==
X-Gm-Message-State: AOAM531dKr7XcqXCRKyf1tWEIzhHGiqxiDzsrnFEtr6EQivl2zba/8Ec
        pywgFK+IrbSV2MHYGv3j1iE=
X-Google-Smtp-Source: ABdhPJzo8dmr6ANuwwG9309zjXl36QLClVbpSRZefvqsQCr/79H9xiCgvC3guibiaLfP6rovR8pCcA==
X-Received: by 2002:a17:90a:1a50:: with SMTP id 16mr2350957pjl.82.1644775421825;
        Sun, 13 Feb 2022 10:03:41 -0800 (PST)
Received: from [192.168.1.46] (bb42-60-144-185.singnet.com.sg. [42.60.144.185])
        by smtp.gmail.com with ESMTPSA id d22sm3679331pgv.18.2022.02.13.10.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Feb 2022 10:03:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------b0E0UhftInl7b1THt7IAGy56"
Message-ID: <e58c5085-c351-a7a6-fe97-3da6eb1a804f@gmail.com>
Date:   Mon, 14 Feb 2022 02:03:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [syzbot] kernel BUG in ext4_es_cache_extent
Content-Language: en-US
To:     syzbot <syzbot+c7358a3cd05ee786eb31@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu
References: <0000000000003d898d05d759c00a@google.com>
From:   Phi Nguyen <phind.uet@gmail.com>
In-Reply-To: <0000000000003d898d05d759c00a@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a multi-part message in MIME format.
--------------b0E0UhftInl7b1THt7IAGy56
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/2022 9:49 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9f7fb8de5d9b Merge tag 'spi-fix-v5.17-rc2' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=148d0304700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b4a89edfcc8f7c74
> dashboard link: https://syzkaller.appspot.com/bug?extid=c7358a3cd05ee786eb31
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124e0abfb00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1758f610700000
> 
> Bisection is inconclusive: the issue happens on the oldest tested release.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12758738700000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=11758738700000
> console output: https://syzkaller.appspot.com/x/log.txt?x=16758738700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c7358a3cd05ee786eb31@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 1051
> EXT4-fs (loop0): ext4_check_descriptors: Checksum for group 0 failed (60935!=0)
> EXT4-fs (loop0): mounted filesystem without journal. Quota mode: writeback.
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/extents_status.c:899!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 3587 Comm: syz-executor288 Not tainted 5.17.0-rc2-syzkaller-00039-g9f7fb8de5d9b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:ext4_es_cache_extent+0x4e8/0x550 fs/ext4/extents_status.c:899
> Code: 00 48 c7 c7 e0 6c c1 89 c6 05 71 25 6f 0b 01 e8 b0 b6 f6 06 e9 5a ff ff ff e8 94 9d 68 ff 0f 0b e9 d7 fc ff ff e8 88 9d 68 ff <0f> 0b e8 81 9d 68 ff 0f 0b e9 13 fe ff ff e8 25 df af ff e9 c2 fb
> RSP: 0018:ffffc90001abee80 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 00000000000013de RCX: 0000000000000000
> RDX: ffff88807deb0000 RSI: ffffffff820fd0f8 RDI: 0000000000000003
> RBP: ffff888074e6f048 R08: 00000000ffffffff R09: 0000000000000000
> R10: ffffffff820fce3c R11: 0000000000000000 R12: 0000000000000001
> R13: 00000000ffffffff R14: 1ffff92000357dd1 R15: 00008f1cffffffff
> FS:  0000555556ad6300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f117149e4b0 CR3: 000000007cc1f000 CR4: 0000000000350ee0
> Call Trace:
>   <TASK>
>   ext4_cache_extents+0x13e/0x2d0 fs/ext4/extents.c:518
>   ext4_find_extent+0x8f6/0xd10 fs/ext4/extents.c:916
>   ext4_ext_map_blocks+0x1e2/0x5f30 fs/ext4/extents.c:4098
>   ext4_map_blocks+0x9ca/0x18a0 fs/ext4/inode.c:563
>   ext4_getblk+0x553/0x6b0 fs/ext4/inode.c:849
>   ext4_bread_batch+0x7c/0x550 fs/ext4/inode.c:923
>   __ext4_find_entry+0x482/0x1050 fs/ext4/namei.c:1600
>   ext4_lookup_entry fs/ext4/namei.c:1701 [inline]
>   ext4_lookup fs/ext4/namei.c:1769 [inline]
>   ext4_lookup+0x4fc/0x730 fs/ext4/namei.c:1760
>   __lookup_slow+0x24c/0x480 fs/namei.c:1707
>   lookup_slow fs/namei.c:1724 [inline]
>   walk_component+0x40f/0x6a0 fs/namei.c:2020
>   link_path_walk.part.0+0x7ef/0xf70 fs/namei.c:2347
>   link_path_walk fs/namei.c:2272 [inline]
>   path_openat+0x266/0x2940 fs/namei.c:3605
>   do_filp_open+0x1aa/0x400 fs/namei.c:3636
>   do_sys_openat2+0x16d/0x4d0 fs/open.c:1214
>   do_sys_open fs/open.c:1230 [inline]
>   __do_sys_openat fs/open.c:1246 [inline]
>   __se_sys_openat fs/open.c:1241 [inline]
>   __x64_sys_openat+0x13f/0x1f0 fs/open.c:1241
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f8e44f22f19
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff98aa3238 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8e44f22f19
> RDX: 000000000000c880 RSI: 0000000020000100 RDI: 0000000000000005
> RBP: 00007f8e44ee27b0 R08: 0000000800000015 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8e44ee2840
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:ext4_es_cache_extent+0x4e8/0x550 fs/ext4/extents_status.c:899
> Code: 00 48 c7 c7 e0 6c c1 89 c6 05 71 25 6f 0b 01 e8 b0 b6 f6 06 e9 5a ff ff ff e8 94 9d 68 ff 0f 0b e9 d7 fc ff ff e8 88 9d 68 ff <0f> 0b e8 81 9d 68 ff 0f 0b e9 13 fe ff ff e8 25 df af ff e9 c2 fb
> RSP: 0018:ffffc90001abee80 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 00000000000013de RCX: 0000000000000000
> RDX: ffff88807deb0000 RSI: ffffffff820fd0f8 RDI: 0000000000000003
> RBP: ffff888074e6f048 R08: 00000000ffffffff R09: 0000000000000000
> R10: ffffffff820fce3c R11: 0000000000000000 R12: 0000000000000001
> R13: 00000000ffffffff R14: 1ffff92000357dd1 R15: 00008f1cffffffff
> FS:  0000555556ad6300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f117149e4b0 CR3: 000000007cc1f000 CR4: 0000000000350ee0
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 

The non-journal mounted fs is corrupted, syzbot was able to mount it 
because a [fast commit] patch exclude its inodes from verification process.

#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

--------------b0E0UhftInl7b1THt7IAGy56
Content-Type: text/plain; charset=UTF-8; name="ext4_es_cache_extent.patch"
Content-Disposition: attachment; filename="ext4_es_cache_extent.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL2V4dDQvaW5vZGUuYyBiL2ZzL2V4dDQvaW5vZGUuYwppbmRleCAw
MWM5ZTRmNzQzYmEuLjM4NWY0YWU3MTU3MyAxMDA2NDQKLS0tIGEvZnMvZXh0NC9pbm9kZS5j
CisrKyBiL2ZzL2V4dDQvaW5vZGUuYwpAQCAtNDkxMiw3ICs0OTEyLDcgQEAgc3RydWN0IGlu
b2RlICpfX2V4dDRfaWdldChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCB1bnNpZ25lZCBsb25n
IGlubywKIAkJZ290byBiYWRfaW5vZGU7CiAJfSBlbHNlIGlmICghZXh0NF9oYXNfaW5saW5l
X2RhdGEoaW5vZGUpKSB7CiAJCS8qIHZhbGlkYXRlIHRoZSBibG9jayByZWZlcmVuY2VzIGlu
IHRoZSBpbm9kZSAqLwotCQlpZiAoIShFWFQ0X1NCKHNiKS0+c19tb3VudF9zdGF0ZSAmIEVY
VDRfRkNfUkVQTEFZKSAmJgorCQlpZiAoIShqb3VybmFsICYmIEVYVDRfU0Ioc2IpLT5zX21v
dW50X3N0YXRlICYgRVhUNF9GQ19SRVBMQVkpICYmCiAJCQkoU19JU1JFRyhpbm9kZS0+aV9t
b2RlKSB8fCBTX0lTRElSKGlub2RlLT5pX21vZGUpIHx8CiAJCQkoU19JU0xOSyhpbm9kZS0+
aV9tb2RlKSAmJgogCQkJIWV4dDRfaW5vZGVfaXNfZmFzdF9zeW1saW5rKGlub2RlKSkpKSB7
Cg==

--------------b0E0UhftInl7b1THt7IAGy56--
