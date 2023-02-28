Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BE26A626D
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Feb 2023 23:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjB1Wcr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Feb 2023 17:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjB1Wcr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Feb 2023 17:32:47 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EBE2ED5C
        for <linux-ext4@vger.kernel.org>; Tue, 28 Feb 2023 14:32:45 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31SMUPCV016770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 17:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677623428; bh=z4a5dDxBQA7AcZTaXSR++HSOb7UmJWz7GB0EAM00kaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=IWHmt5JvPjAWDcjEjQdEQHk3pb9ibzUUtGME8OIHZ+4x7pBLQsgEDM2GS27+eDgtC
         sYtpQ0KcBUmFfOZ1HiS1wfLKhk8KPEc6/yS9FcPEA1MgGdroLC8BcXSFGTIRhHPuWA
         Q+RWDyCS6Hcvq9+YFOt8HgSwbrOwnv+dGZrLF9IRD7uvQRKVtxbtNw96Qd5BzEo61K
         Z94BHujMBNcVQ87gv64Q6zqZhLcF+8+OFtjVI4HFtZk8YCFz5QKNuv28JWSXGpRfs1
         iEDspwav6z4t94E/p8XEk0FT0O8Uiqhesyg10D/sDRR7CbqIRJ2/9pzpIRGkT20KI9
         6bmpusgPFxVsw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3D0AE15C3593; Tue, 28 Feb 2023 17:30:25 -0500 (EST)
Date:   Tue, 28 Feb 2023 17:30:25 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Kemeng Shi <shikemeng@huaweicloud.com>, adilger.kernel@dilger.ca,
        jack@suse.cz, ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/20] Some bugfix and cleanup to mballoc
Message-ID: <Y/6AgYotmMdjei3w@mit.edu>
References: <20230228114306.3328235-1-shikemeng@huaweicloud.com>
 <87356pwxyc.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87356pwxyc.fsf@doe.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 28, 2023 at 10:04:35PM +0530, Ritesh Harjani wrote:
> Kemeng Shi <shikemeng@huaweicloud.com> writes:
> 
> > Hi, this series contain some random cleanup patches and some bugfix
> > patches to make EXT4_MB_HINT_GOAL_ONLY work properly, protect pa->pa_free
> > from race and so on. More details can be found in git log.
> > Thanks!
> 
> Hi Kemeng,
> 
> Did you run any testing on these patches? Because I was very easily able
> to hit ext/009 causing kernel BUG_ON with default mkfs/mount options.
> It's always a good and recommended practice to ensure some level of
> testing on any of the patches we submit to community for review
> and call out in the cover letter on what has been tested and what is not.

Hi Kemeng,

If you need help running xfstests, I maintain a test appliance which
makes it very easy to run xfstests on development kernels.  Please see:

https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-xfstests.md
https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

This test appliance can also be run on Android devices and using
Google Compute Engine; for more information see:

	https://thunk.org/android-xfstests
	https://thunk.org/gce-xfstests

If you're just getting started, I recommend that you start with
kvm-xfstests, and this is the simplest way to get started.

Cheers,

					- Ted

