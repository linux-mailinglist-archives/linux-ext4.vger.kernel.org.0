Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E94652CB46
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 06:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiESErP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 00:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbiESErO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 00:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECD62C5D9D
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 21:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652935631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ozKv8JuFCr47tZ31HF8OOTFb0OFMhv8avzY8kqwcUMM=;
        b=a3gewSesY6uZE7CdCoL/ukCjX+rheYVOgsGDUPP+rKqhcqI0C+thy/HXznaNVSdiYddcwU
        0+RepXMkco7FyFPMrGQSpihn2mgMemVao+BFOAht4lwYHCMjtmUYLH2+igsi+asm4Q3orB
        T8Y4q2fX9xSfmkBgQN0vPsS+rxYKFNc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-W72qeGCAM3WhxQmk1L03cw-1; Thu, 19 May 2022 00:47:09 -0400
X-MC-Unique: W72qeGCAM3WhxQmk1L03cw-1
Received: by mail-qt1-f199.google.com with SMTP id t25-20020a05622a181900b002f3b32a6e30so3361604qtc.11
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 21:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ozKv8JuFCr47tZ31HF8OOTFb0OFMhv8avzY8kqwcUMM=;
        b=SuaSI+gxOU1PmucCCcnhAYPY2GdiNdjvJJ9pSglu+aaKd0V2khLe5XbUD8UlAVAvwF
         okNXQANEeXBS5iDVa8DYqRXfFqKVbvCUw3ebEUJdaD5uDR6ZhhVKk402qS8HtG/s+tZX
         3X4BJm9ZFMRnvKdwf0T0pMz5f73BGTa9pshO7bxe48KpyYCWo9TjhMDG5Ob++gdeHhLJ
         vr6PLBw7mY5OfJdpQ0lfjX7G/wd5Bta5VXwK6Poz4GIQGNesApRXQTBKO7H3ERfo1izB
         DUqMOCk4Vhin2XCytWb8HtaT5WRkNYgXOM/Ik/NcggnadspEonEyy0F4qSQLmuZCAIUp
         wSrQ==
X-Gm-Message-State: AOAM5301y338e1Tr+bdBvfMaLqUFKtoL0o5s3unodclYfTDfVqjf5b5L
        IbsFOoGRyaz6mHWPw3hdNvyi0O6k2pnc47t+nZjxSQjw2ORUVUsZgwYww1Nf/F7CXGttslUCll/
        0RpRL0Aa38rH9BJEZnX8/mg==
X-Received: by 2002:a37:8846:0:b0:6a0:f6f1:a015 with SMTP id k67-20020a378846000000b006a0f6f1a015mr1977091qkd.386.1652935628527;
        Wed, 18 May 2022 21:47:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSs62f/3NAVJl6r6+Zj2S/Ryg5IxZ0abiKNKkm+nSFAtRkjbVrEx8KDPRBdZbqDAJw4g7n+A==
X-Received: by 2002:a37:8846:0:b0:6a0:f6f1:a015 with SMTP id k67-20020a378846000000b006a0f6f1a015mr1977081qkd.386.1652935628246;
        Wed, 18 May 2022 21:47:08 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g206-20020a379dd7000000b0069fcf0da629sm677462qke.134.2022.05.18.21.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 21:47:07 -0700 (PDT)
Date:   Thu, 19 May 2022 12:47:01 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-ext4@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
Subject: Re: [xfstests PATCH 0/2] update test_dummy_encryption testing in
 ext4/053
Message-ID: <20220519044701.w7lf5tabdsl3cwra@zlang-mailbox>
References: <20220501051928.540278-1-ebiggers@kernel.org>
 <20220518141911.zg73znk2o2krxxwk@zlang-mailbox>
 <YoUu60S2AjP2fEOk@sol.localdomain>
 <20220518181607.fpzqmtnaky5jdiuw@zlang-mailbox>
 <YoVspJ6NUByHPn3r@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoVspJ6NUByHPn3r@sol.localdomain>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 18, 2022 at 03:01:08PM -0700, Eric Biggers wrote:
> Zorro, can you fix your email configuration?  Your emails have a
> Mail-Followup-To header that excludes you, so replying doesn't work correctly;
> I had to manually fix the recipients list.  If you're using mutt, you need to
> add 'set followup_to = no' to your muttrc.

Oh, I didn't notice that, I use neomutt, it might enable the followup_to by
default. OK, I've set followup_to = no, and restart my neomutt. Hope it helps:)

> 
> On Thu, May 19, 2022 at 02:16:07AM +0800, Zorro Lang wrote:
> > > > 
> > > > And I saw some discussion under this patchset, and no any RVB, so I'm wondering
> > > > if you are still working/changing on it?
> > > > 
> > > 
> > > I might add a check for kernel version >= 5.19 in patch 1.  Otherwise I'm not
> > > planning any more changes.
> > 
> > Actually I don't think the kernel version check (in fstests) is a good method. Better
> > to check a behavior/feature directly likes those "_require_*" functions.
> > 
> > Why ext4/053 need >=5.12 or even >=5.19, what features restrict that? If some
> > features testing might break the garden image (.out file), we can refer to
> > _link_out_file(). Or even split this case to several small cases, make ext4/053
> > only test old stable behaviors. Then use other cases to test new features,
> > and use _require_$feature_you_test for them (avoid the kernel version
> > restriction).
> 
> This has been discussed earlier in this thread as well as on the patch that
> added ext4/053 originally.  ext4/053 has been gated on version >= 5.12 since the
> beginning.  Kernel version checks are certainly bad in general, but ext4/053 is
> a very nit-picky test intended to detect if anything changed, where a change
> does not necessarily mean a bug.  So maybe the kernel version check makes sense

Even on old RHEL-8 system (with a variant of kernel 3.10), the ext4/053 fails
as [1]. Most of mount options test passed, only a few options (inlinecrypt,
test_dummy_encryption, prefetch_block_bitmaps, dioread_lock) might not be
supported.

I think it's not necessary to mix all old and new ext4 mount options test into
one single test cause. If it's too complicated, we can move some functions into
common/ext4 (or others you like), split ext4/053 to several cases. Let ext4/053
test stable enough mount option (supported from an old enough kernel). Then let
other newer mount options in different single cases.

For example, make those CONFIG_FS_ENCRYPTION* tests into a seperated case,
and add something likes require_(fs_encryption?), and src/feature.c can be
used too. Then about dioread_lock and prefetch_block_bitmaps things, we can
deal with them specially, or split them out from ext4/053. I even don't mind
if you test ext2 and ext3/4 in separate case.

That's my personal opinion, I can try to help to do that after merging this
patchset, if ext4 forks agree and would like to give me some supports
(review and Q&A). Anyway, as it's an ext4 specific testing, I respect the
opinion from ext4 list particularly.

[1]
+SHOULD FAIL remounting ext2 "commit=7" (remount unexpectedly succeeded) FAILED
+mounting ext2 "test_dummy_encryption=v1" (failed mount) FAILED
+mounting ext2 "test_dummy_encryption=v2" (failed mount) FAILED
+mounting ext2 "test_dummy_encryption=v3" (failed mount) FAILED
+mounting ext2 "inlinecrypt" (failed mount) FAILED
+mounting ext2 "prefetch_block_bitmaps" (failed mount) FAILED
+mounting ext2 "no_prefetch_block_bitmaps" (failed mount) FAILED
+mounting ext3 "test_dummy_encryption=v1" (failed mount) FAILED
+mounting ext3 "test_dummy_encryption=v2" (failed mount) FAILED
+mounting ext3 "test_dummy_encryption=v3" (failed mount) FAILED
+mounting ext3 "inlinecrypt" (failed mount) FAILED
+mounting ext3 "prefetch_block_bitmaps" (failed mount) FAILED
+mounting ext3 "no_prefetch_block_bitmaps" (failed mount) FAILED
+mounting ext4 "nodioread_nolock" (failed mount) FAILED
+mounting ext4 "dioread_lock" checking "nodioread_nolock" (not found) FAILED
+mounting ext4 "test_dummy_encryption=v1" (failed mount) FAILED
+mounting ext4 "test_dummy_encryption=v2" (failed mount) FAILED
+mounting ext4 "test_dummy_encryption=v3" (failed mount) FAILED
+mounting ext4 "inlinecrypt" (failed mount) FAILED
+mounting ext4 "prefetch_block_bitmaps" (failed mount) FAILED
+mounting ext4 "no_prefetch_block_bitmaps" (failed mount) FAILED

> there.  Lukas, any thoughts about the issues you encountered when running
> ext4/053 on older kernels?
> 
> If you don't want a >= 5.19 version check for the test_dummy_encryption test
> case as well, then I'd rather treat the kernel patch
> "ext4: only allow test_dummy_encryption when supported" as a bug fix and
> backport it to the LTS kernels.  The patch is fixing the mount option to work
> the way it should have worked originally.  Either that or we just remove the
> test_dummy_encryption test case as Ted suggested.

Oh, I'd not like to push anyone to do more jobs:) And there're many Linux
distributions with their downstream kernel, not only LTS kernel project.
So I don't mean to make fstests' cases support the oldest existing kernel
version, just hope some common cases try not *only* work for the latest
one, if they have the chance :)

Thanks,
Zorro

> 
> - Eric
> 

