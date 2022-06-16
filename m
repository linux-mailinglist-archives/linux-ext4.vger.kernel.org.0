Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED0254DAAE
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jun 2022 08:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242273AbiFPGbK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jun 2022 02:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358857AbiFPGbI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jun 2022 02:31:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB9856B1C;
        Wed, 15 Jun 2022 23:31:06 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u2so649796pfc.2;
        Wed, 15 Jun 2022 23:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9PoyXeo8w59gzIqepibu5F5AybFdXm23NrFGABzH7Ew=;
        b=bEQYkIOFFmG8eTbH2eWwMPLR0QLXqP9/PEJnDDySzs4CfbhHutzIFgioMze4l1dzFq
         V0T7VyQlNnknC43q7ufF7drDmdaCWpdvT3xCmnjjRAd1gD6gJw2RLJWZfySO3/1F0mOp
         Rw4rwMDYkft1ZeElK5s4T2wcrXt7ZoTFmnOxDaAYDZoNwaPl2/4x3naSXhDtJKqdAVCI
         e+JTXl42EzLKZL4yRMxDg5AqIOJ4PudPlTHwlZvxd0R5mSVkfBUIkuI9AIHl9xejA3o/
         qBsUsAEUIHgC8+/az5ZW2on2ENiTDtxwPW6EVZKHWAyuQQ06+mQEdqswbs1Jdx6Q6U2t
         /tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9PoyXeo8w59gzIqepibu5F5AybFdXm23NrFGABzH7Ew=;
        b=4u9lWMJis/XyIeMKPpQOE4heL7DlBE+rd2S5QrtzYzc/pmtv6viMePRSI/47c9xY5r
         5bpSdELNakmGdPunSpYj/WLi7wn8klDaBVvCeTB5wii0pUef2asvtLQP2TYYO+ZAUGjT
         ocGkcIfdvdaE8BaY2ZWh71JSON/JvlIXwfe3q1uwXqWtJorrWbBV7Bl4t1Fxg7OhPiiR
         lz4+Sjr/mLAbohfym9yk80rIekr/y7oTqzJmv0jm7S4k44pzPXUGCXwEKIejoFU7tbyW
         8amVq3+wQpc/vWLlsWEwoHf8heRX0HZlZ7b142A8sKMMe3bbIdYSDtc5OeZNKBFswnWw
         TwhA==
X-Gm-Message-State: AJIora9hx4RFap1U1mZYHtMSzEgKXiGZpOKqltJCeROXKqbMWDwxQB25
        2I96x6oGyod90xtjrQ2p9LA=
X-Google-Smtp-Source: AGRyM1vnftfhFSvMb97STlB98fCkVfxsVXdb/X77oTnOdUOCZYFItWscvxTI8n0t06TRzu4elVCMcg==
X-Received: by 2002:a62:2584:0:b0:520:785d:2ba with SMTP id l126-20020a622584000000b00520785d02bamr3310658pfl.55.1655361065864;
        Wed, 15 Jun 2022 23:31:05 -0700 (PDT)
Received: from localhost ([2406:7400:63:5d34:e6c2:4c64:12ae:aa11])
        by smtp.gmail.com with ESMTPSA id i3-20020a63a843000000b003fd7e217686sm768172pgp.57.2022.06.15.23.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 23:31:05 -0700 (PDT)
Date:   Thu, 16 Jun 2022 12:01:00 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ye Bin <yebin10@huawei.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ext4: fix bug_on in ext4_iomap_begin as race
 between bmap and write
Message-ID: <20220616063100.mkuqs6cxcqf6u234@riteshh-domain>
References: <20220615135850.1961759-1-yebin10@huawei.com>
 <20220615152139.vp64tnv46enwnfcs@riteshh-domain>
 <20220615153123.ab32zt75q7yn7jc5@riteshh-domain>
 <20220615172609.oydxhjw7exas23hd@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615172609.oydxhjw7exas23hd@quack3.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/06/15 07:26PM, Jan Kara wrote:
> On Wed 15-06-22 21:01:23, Ritesh Harjani wrote:
> > On 22/06/15 08:51PM, Ritesh Harjani wrote:
> > > On 22/06/15 09:58PM, Ye Bin wrote:
> > > > We got issue as follows:
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 3 PID: 9310 at fs/ext4/inode.c:3441 ext4_iomap_begin+0x182/0x5d0
> > > > RIP: 0010:ext4_iomap_begin+0x182/0x5d0
> > > > RSP: 0018:ffff88812460fa08 EFLAGS: 00010293
> > > > RAX: ffff88811f168000 RBX: 0000000000000000 RCX: ffffffff97793c12
> > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> > > > RBP: ffff88812c669160 R08: ffff88811f168000 R09: ffffed10258cd20f
> > > > R10: ffff88812c669077 R11: ffffed10258cd20e R12: 0000000000000001
> > > > R13: 00000000000000a4 R14: 000000000000000c R15: ffff88812c6691ee
> > > > FS:  00007fd0d6ff3740(0000) GS:ffff8883af180000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 00007fd0d6dda290 CR3: 0000000104a62000 CR4: 00000000000006e0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > Call Trace:
> > > >  iomap_apply+0x119/0x570
> > > >  iomap_bmap+0x124/0x150
> > > >  ext4_bmap+0x14f/0x250
> > > >  bmap+0x55/0x80
> > > >  do_vfs_ioctl+0x952/0xbd0
> > > >  __x64_sys_ioctl+0xc6/0x170
> > > >  do_syscall_64+0x33/0x40
> > > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > >
> > > > Above issue may happen as follows:
> > > >           bmap                    write
> > > > bmap
> > > >   ext4_bmap
> > > >     iomap_bmap
> > > >       ext4_iomap_begin
> > > >                             ext4_file_write_iter
> > > > 			      ext4_buffered_write_iter
> > > > 			        generic_perform_write
> > > > 				  ext4_da_write_begin
> > > > 				    ext4_da_write_inline_data_begin
> > > > 				      ext4_prepare_inline_data
> > > > 				        ext4_create_inline_data
> > > > 					  ext4_set_inode_flag(inode,
> > > > 						EXT4_INODE_INLINE_DATA);
> > > >       if (WARN_ON_ONCE(ext4_has_inline_data(inode))) ->trigger bug_on

Actually it's only a WARN_ON_ONCE and not a bug_on.
(You might have made panic_on_warn set to 1 in your testing)

> > > >
> > > > To solved above issue hold inode lock in ext4_bamp.
> > > 											^^^ ext4_bmap()
> > >
> > > I checked the paths where bmap() kernel api can be called i.e. from jbd2/fc and
> > > generic_swapfile_activate() (apart from ioctl())
> > > For jbd2, it will be called with j_inode within bmap(), hence taking a inode lock
> > > of the inode passed within ext4_bmap() (j_inode in this case) should be safe here.
> > > Same goes with swapfile path as well.
> > >
> > > However I feel maybe we should hold inode_lock_shared() since there is no
> > > block/extent map layout changes that can happen via ext4_bmap().
> > > Hence read lock is what IMO should be used here.
> >
> > On second thoughts, shoudn't we use ext4_iomap_report_ops here?  Can't
> > recollect why we didn't use ext4_iomap_report_ops for iomap_bmap() in the
> > first place. Should be good to verify it once.
>
> Hum, but I guess there's a deeper problem than ext4_bmap(). Generally we
> have places doing block mapping (such as ext4_writepages(), readahead, or
> page fault) where we don't hold i_rwsem and racing
> ext4_create_inline_data() could confuse them? I guess we need to come up

You are right, i_rwsem won't be able to protect against such races which you
described. So, we actually use EXT4_I(inode)->xattr_sem for inline data
serialization.

So for this issue, I think if we should move from ext4_iomap_ops to
ext4_iomap_report_ops. ext4_iomap_begin_report does takes care of read locking
xattr_sem to properly report if it's a inline_data and similarly iomap_bmap
reports 0 (which it should) in case of iomap->type != IOMAP_MAPPED
(since in this case ext4_iomap_begin_report() will give IOMAP_INLINE)

Thoughts?

-ritesh


> with a sound scheme how inline data creation is serialized with these
> operations (or just decide to remove the inline data feature altogether as
> we already discussed once because the complexity likely is not worth the
> gain).
>
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
