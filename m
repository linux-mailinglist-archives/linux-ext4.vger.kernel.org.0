Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF81576688
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Jul 2022 20:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiGOSI2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Jul 2022 14:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiGOSI2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Jul 2022 14:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FA506392D
        for <linux-ext4@vger.kernel.org>; Fri, 15 Jul 2022 11:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657908505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1rPBnU2RUL5AiOnVTAOyHK1wMfPi1LA04wHJim9tiyk=;
        b=adHsiFRPy/NFlLWg+piPlEWewI8VuGdpVC5/S3pfO01qeF1kwb2ttCn59tbSjfNhKe7B7K
        3DHUeRa5DTw/ALSwV8OouVUaRX6XeQquLBgGPFT+F0mVleppjukiUppgfX3NVy2gHhPAvW
        M7CwRhWK4s8jDFsVR3Qs2aeIHCZ8lHE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-fx8E4uBYOhuRHa2os7A1Mw-1; Fri, 15 Jul 2022 14:08:24 -0400
X-MC-Unique: fx8E4uBYOhuRHa2os7A1Mw-1
Received: by mail-qk1-f197.google.com with SMTP id de4-20020a05620a370400b006a9711bd9f8so3949973qkb.9
        for <linux-ext4@vger.kernel.org>; Fri, 15 Jul 2022 11:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1rPBnU2RUL5AiOnVTAOyHK1wMfPi1LA04wHJim9tiyk=;
        b=mrmHOcheq0Ls3Skr/f9qhQKY1jzUH9LU6uhUxKlaSUvy8bkbM+kdzUE4JTgocRMda1
         1HJmnDVxuKH8hydEsK0D3KmH7dXPzl4UjBLHy8cie0mHMAwGoMkP+ae1ixcAKjEZ6zDA
         BDvb6cIO3gViGwuZQ0dnTA0MVg1IKwV62AI9fAghsASVakA1HAqVFZTrhDlSAH2Q1ztn
         lffQU9TCdU570nRhE78kvQIbQU8YQ9EzkJ9dZBRa0fNtNe8+i+pk2nbBh/6qxx8JAWgj
         +Niq3ePcYPyXWF7TmkD4RhOqJCoiAzi0VcQjJKRX7IHb0ALJXE12PZRaUtnORlLnPSbt
         pbUQ==
X-Gm-Message-State: AJIora+eKb/WiA6mbbdhibx/suPkKoazuQZqEtv3LpuFRqd/AXSxbOxY
        lU5qako7iJu0mY++yvW4MxWOAmdVO8NX/S7UmRQEPSgSb3XcTV8Vx2+e+zu4+a6s1K0BX8XK3mM
        hYq4QKw8YKs4fBYFyAAE/7g==
X-Received: by 2002:a05:620a:4007:b0:6b5:d88b:6d42 with SMTP id h7-20020a05620a400700b006b5d88b6d42mr461780qko.180.1657908503532;
        Fri, 15 Jul 2022 11:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tod/zt6okvJvxAZnL0jRKHfEBgB/LKlQpD9NW4YeZf6EmE+bdwe8MODDc3JhwxAv+4W/Vx0Q==
X-Received: by 2002:a05:620a:4007:b0:6b5:d88b:6d42 with SMTP id h7-20020a05620a400700b006b5d88b6d42mr461760qko.180.1657908503136;
        Fri, 15 Jul 2022 11:08:23 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w18-20020a05620a445200b006a37c908d33sm4883965qkp.28.2022.07.15.11.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 11:08:21 -0700 (PDT)
Date:   Sat, 16 Jul 2022 02:08:15 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>, Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ext4: resize fs after resize_inode without e2fsck
Message-ID: <20220715180815.gegmapvruor6vin3@zlang-mailbox>
References: <20220713092859.3881376-1-sunke32@huawei.com>
 <20220713092859.3881376-2-sunke32@huawei.com>
 <20220714154607.qq6cqgvncxhsn66w@zlang-mailbox>
 <YtCSAjiMc9RElnHu@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtCSAjiMc9RElnHu@mit.edu>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 14, 2022 at 06:00:34PM -0400, Theodore Ts'o wrote:
> On Thu, Jul 14, 2022 at 11:46:07PM +0800, Zorro Lang wrote:
> > On Wed, Jul 13, 2022 at 05:28:58PM +0800, Sun Ke wrote:
> > > +
> > > +# forget to run requested e2fsck after resize_inode
> > > +$TUNE2FS_PROG -O ^resize_inode $SCRATCH_DEV | grep -w "e2fsck"
> > > +
> > > +_scratch_mount
> > > +
> > > +# resize fs will trigger NULL pointer in ext4_flex_group_add
> > > +$RESIZE2FS_PROG $SCRATCH_DEV 1G >> $seqres.full 2>&1
> > > +
> > > +echo "Silence is golden"
>   ...
> > > diff --git a/tests/ext4/057.out b/tests/ext4/057.out
> > > new file mode 100644
> > > index 00000000..4784ad7e
> > > --- /dev/null
> > > +++ b/tests/ext4/057.out
> > > @@ -0,0 +1,3 @@
> > > +QA output created by 057
> > > +Please run e2fsck -f on the filesystem.
> > 
> > If you hope to match this line, means this case isn't "Silence is golden".
> > 
> > I don't know why you'd to have this line, it looks not suit to be golden
> > image. If you'd like to make sure current ext4 supports "resize_inode"
> > feature, you can use:
> >   _require_scratch_ext4_feature resize_inode
> 
> That's not the problem.
> 
> The "tune2fs -O ^resize_inode" command is printing that message as a
> reminder that it would be a Really Good idea to run e2fsck on the file
> system, because tune2fs doesn't completely remove the resize inode
> after turning off that feature.
> 
> The commit which this test is trying to verify is that the kernel
> won't oops if the system adminsitrator ignores the rather explicit
> request:
> 
> Please run e2fsck -f on the filesystem.
> 
> ... and blithely mounts the file system without running fsck -f on the
> file system first.  While it could be argued that a system
> administrator which fails to follow instructions deserves everything
> they get, we decided the as a quality of implementation issue, it
> would be better if the kernel didn't dereference a NULL pointer in
> that case.  :-)
> 
> The one thing I'll note is that it is possible that at some point in
> the future, tune2fs could be improved so that it cleanly removes the
> resize_inode when the resize inode feature is removed, so that running
> "fsck.ext4 -f" is no longer necessary.  So if you want to future-proof

Good to know :)

> the test so it doesn't fail once tune2fs is made more idiot-proof, it
> might be better if the test did something like this:
> 
> mke2fs -t ext4 -O ^resize_inode /dev/vdc 512m
> debugfs -w -R "set_super_value s_reserved_gdt_blocks 100" /dev/vdc

So make sure there're reserved GDT blocks, even if disable resize_inode
feature.

> mount -t ext4 /dev/vdc /vdc
> resize2fs /dev/vdc 1G

Thanks Ted! That's really helpful to get review points from ext4 expert.

Hi Ke, would you mind re-sending this case refer to above review points?
You can refer to below code, but I didn't test it, so please test and make
sure it works and can reproduce the bug. Feel free to improve it if something
wrong.

_require_command "$DEBUGFS_PROG" debugfs
...

MKFS_OPTIONS="-O ^resize_inode $MKFS_OPTIONS" _scratch_mkfs_sized $dev_size \
	>>$seqres.full 2>&1 || _fail "mkfs failed"
$DEBUGFS_PROG -w -R "set_super_value s_reserved_gdt_blocks 100" $SCRATCH_DEV \
	>>$seqres.full 2>&1
$DEBUGFS_PROG -R "show_super_stats -h" $SCRATCH_DEV 2>/dev/null | \
	grep "Reserved GDT blocks"
_scratch_mount
$RESIZE2FS_PROG $SCRATCH_DEV 1g >> $seqres.full 2>&1


Thanks,
Zorro


> 
> Translating the above from commands suitable for manual trial using
> "kvm-xfstests shell" to a proper xfstests script is left as an
> exercise for the reader.  :-)
> 
> 					- Ted
> 

