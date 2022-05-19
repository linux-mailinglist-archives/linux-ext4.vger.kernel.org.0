Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685D252CE60
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 10:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiESIdk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 04:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiESIdj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 04:33:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85D8F71A34
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 01:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652949217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eMbN0+2RdHotu0cNdGJ/suZRDkxbeazZr/7Jv/d0ZbQ=;
        b=Zmmiw4E6omyM3HRHLPoQOAMflbgzDpf096RVOiy4Ocspe+qxLpLfVB3QUnRDCf1Hbwh1zu
        KAyPeNUu6UOb4oO32WKHtnxkAG6aOz3wLSs9KB8H+RCxGjvsoz05uajyGHSORw8AG1pjUg
        ezo7vp6jY6kucpIn7J9AqQagNCfXkCk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-cObo2yURMaGmcP4DrRq69Q-1; Thu, 19 May 2022 04:33:26 -0400
X-MC-Unique: cObo2yURMaGmcP4DrRq69Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40DDB384F80B;
        Thu, 19 May 2022 08:33:26 +0000 (UTC)
Received: from fedora (unknown [10.40.193.239])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B44F7AE4;
        Thu, 19 May 2022 08:33:25 +0000 (UTC)
Date:   Thu, 19 May 2022 10:33:22 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, fstests@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [xfstests PATCH 0/2] update test_dummy_encryption testing in
 ext4/053
Message-ID: <20220519083322.6nfcts7wwevv4eca@fedora>
References: <20220501051928.540278-1-ebiggers@kernel.org>
 <20220518141911.zg73znk2o2krxxwk@zlang-mailbox>
 <YoUu60S2AjP2fEOk@sol.localdomain>
 <20220518181607.fpzqmtnaky5jdiuw@zlang-mailbox>
 <YoVspJ6NUByHPn3r@sol.localdomain>
 <20220519044701.w7lf5tabdsl3cwra@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519044701.w7lf5tabdsl3cwra@zlang-mailbox>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 19, 2022 at 12:47:01PM +0800, Zorro Lang wrote:
> On Wed, May 18, 2022 at 03:01:08PM -0700, Eric Biggers wrote:
> > Zorro, can you fix your email configuration?  Your emails have a
> > Mail-Followup-To header that excludes you, so replying doesn't work correctly;
> > I had to manually fix the recipients list.  If you're using mutt, you need to
> > add 'set followup_to = no' to your muttrc.
> 
> Oh, I didn't notice that, I use neomutt, it might enable the followup_to by
> default. OK, I've set followup_to = no, and restart my neomutt. Hope it helps:)
> 
> > 
> > On Thu, May 19, 2022 at 02:16:07AM +0800, Zorro Lang wrote:
> > > > > 
> > > > > And I saw some discussion under this patchset, and no any RVB, so I'm wondering
> > > > > if you are still working/changing on it?
> > > > > 
> > > > 
> > > > I might add a check for kernel version >= 5.19 in patch 1.  Otherwise I'm not
> > > > planning any more changes.
> > > 
> > > Actually I don't think the kernel version check (in fstests) is a good method. Better
> > > to check a behavior/feature directly likes those "_require_*" functions.
> > > 
> > > Why ext4/053 need >=5.12 or even >=5.19, what features restrict that? If some
> > > features testing might break the garden image (.out file), we can refer to
> > > _link_out_file(). Or even split this case to several small cases, make ext4/053
> > > only test old stable behaviors. Then use other cases to test new features,
> > > and use _require_$feature_you_test for them (avoid the kernel version
> > > restriction).
> > 
> > This has been discussed earlier in this thread as well as on the patch that
> > added ext4/053 originally.  ext4/053 has been gated on version >= 5.12 since the
> > beginning.  Kernel version checks are certainly bad in general, but ext4/053 is
> > a very nit-picky test intended to detect if anything changed, where a change
> > does not necessarily mean a bug.  So maybe the kernel version check makes sense
> 
> Even on old RHEL-8 system (with a variant of kernel 3.10), the ext4/053 fails
> as [1]. Most of mount options test passed, only a few options (inlinecrypt,
> test_dummy_encryption, prefetch_block_bitmaps, dioread_lock) might not be
> supported.

No it does not. On RHEL-8 system the test will not run because of kernel
version test. It will be skipped.

> 
> I think it's not necessary to mix all old and new ext4 mount options test into
> one single test cause. If it's too complicated, we can move some functions into
> common/ext4 (or others you like), split ext4/053 to several cases. Let ext4/053
> test stable enough mount option (supported from an old enough kernel). Then let
> other newer mount options in different single cases.
> 
> For example, make those CONFIG_FS_ENCRYPTION* tests into a seperated case,
> and add something likes require_(fs_encryption?), and src/feature.c can be
> used too. Then about dioread_lock and prefetch_block_bitmaps things, we can
> deal with them specially, or split them out from ext4/053. I even don't mind
> if you test ext2 and ext3/4 in separate case.

Sure, but why to split it? It all should be stable enough, it's user
facing interface, that's the whole point of the test. I certainly see
the benefit of having the test for all ext4 mount option in one test -
it's faster and it's easier to see what's there. I would be agains
splitting it.

As it is now there is only one kernel_gte() check to avoid testing the
entire history. With any new mount option as a separate test we would
still need kernel_gte test to avoid failing on kernels that don't have
the mount option. At least until kernel gains ability to list supported
mount options it's the only test we have.

On the other hand I do see some value in making a new test for a new
mount option. But I don't have a strong opinion about that.

As for the original topic of the discussion, as I said in previous
reply, maybe the right solution here is to treat the change as a bug fix
which is arguably is and let it fail on old behavior.

Thanks!
-Lukas

> 
> That's my personal opinion, I can try to help to do that after merging this
> patchset, if ext4 forks agree and would like to give me some supports
> (review and Q&A). Anyway, as it's an ext4 specific testing, I respect the
> opinion from ext4 list particularly.
> 
> [1]
> +SHOULD FAIL remounting ext2 "commit=7" (remount unexpectedly succeeded) FAILED
> +mounting ext2 "test_dummy_encryption=v1" (failed mount) FAILED
> +mounting ext2 "test_dummy_encryption=v2" (failed mount) FAILED
> +mounting ext2 "test_dummy_encryption=v3" (failed mount) FAILED
> +mounting ext2 "inlinecrypt" (failed mount) FAILED
> +mounting ext2 "prefetch_block_bitmaps" (failed mount) FAILED
> +mounting ext2 "no_prefetch_block_bitmaps" (failed mount) FAILED
> +mounting ext3 "test_dummy_encryption=v1" (failed mount) FAILED
> +mounting ext3 "test_dummy_encryption=v2" (failed mount) FAILED
> +mounting ext3 "test_dummy_encryption=v3" (failed mount) FAILED
> +mounting ext3 "inlinecrypt" (failed mount) FAILED
> +mounting ext3 "prefetch_block_bitmaps" (failed mount) FAILED
> +mounting ext3 "no_prefetch_block_bitmaps" (failed mount) FAILED
> +mounting ext4 "nodioread_nolock" (failed mount) FAILED
> +mounting ext4 "dioread_lock" checking "nodioread_nolock" (not found) FAILED
> +mounting ext4 "test_dummy_encryption=v1" (failed mount) FAILED
> +mounting ext4 "test_dummy_encryption=v2" (failed mount) FAILED
> +mounting ext4 "test_dummy_encryption=v3" (failed mount) FAILED
> +mounting ext4 "inlinecrypt" (failed mount) FAILED
> +mounting ext4 "prefetch_block_bitmaps" (failed mount) FAILED
> +mounting ext4 "no_prefetch_block_bitmaps" (failed mount) FAILED
> 
> > there.  Lukas, any thoughts about the issues you encountered when running
> > ext4/053 on older kernels?
> > 
> > If you don't want a >= 5.19 version check for the test_dummy_encryption test
> > case as well, then I'd rather treat the kernel patch
> > "ext4: only allow test_dummy_encryption when supported" as a bug fix and
> > backport it to the LTS kernels.  The patch is fixing the mount option to work
> > the way it should have worked originally.  Either that or we just remove the
> > test_dummy_encryption test case as Ted suggested.
> 
> Oh, I'd not like to push anyone to do more jobs:) And there're many Linux
> distributions with their downstream kernel, not only LTS kernel project.
> So I don't mean to make fstests' cases support the oldest existing kernel
> version, just hope some common cases try not *only* work for the latest
> one, if they have the chance :)
> 
> Thanks,
> Zorro
> 
> > 
> > - Eric
> > 
> 

