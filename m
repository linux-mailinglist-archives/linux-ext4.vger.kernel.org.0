Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618D66FE6D4
	for <lists+linux-ext4@lfdr.de>; Thu, 11 May 2023 00:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjEJWAw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 May 2023 18:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEJWAw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 May 2023 18:00:52 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867F510FF
        for <linux-ext4@vger.kernel.org>; Wed, 10 May 2023 15:00:50 -0700 (PDT)
Received: from letrec.thunk.org (vancouverconventioncentre.com [72.28.92.214] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34AM0JRR020073
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 18:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683756023; bh=bRCtqigYKljj45yS4MLUBurFYAAhtCU48P1UiLbW8lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KGOzyrh6kFILiMySKofqticbqa0YiESme1aCRqT+nh2k5M/wVUiRtbo9q7MJtyXv7
         lnisbc8qCmtKTORmV1lt/FzY1DT1WnWuTBpTNZFz2AhN8w+w9EfsTnYIjAHeecsP7D
         m3trO15tyViYOtfV1Vte5/T8idahj8vMNL3kmA1Bl9K3eTTqqE8cGz5nr/IrKNHqNl
         oOrtderaOnco4Tc0BmO9Xm6I1tBkmFZj+LOXU2bzxn39FsseEmUfwzZsYGQby7q1ps
         VzIl/K/6QLkF/X4Z5vX4FcTtVB+iNvB48K/JKWNq6ZOY8fnkykyKBVDyZ6XqiE0kz5
         0o2AGqC49pCYg==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 1B3AD8C03A8; Wed, 10 May 2023 18:00:18 -0400 (EDT)
Date:   Wed, 10 May 2023 18:00:18 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     youling 257 <youling257@gmail.com>, jack@suse.cz,
        hch@infradead.org, hch@lst.de, linux-ext4@vger.kernel.org,
        ritesh.list@gmail.com, keescook@chromium.org
Subject: Re: [PATCH v4 12/13] ext4: Stop providing .writepage hook
Message-ID: <ZFwT8gYip+nPmo0w@mit.edu>
References: <20221207112722.22220-12-jack@suse.cz>
 <20230508175108.6986-1-youling257@gmail.com>
 <20230509050227.GA1180@quark.localdomain>
 <ZFqSwegsnsqi3vAu@mit.edu>
 <CAOzgRdbkno+k1_vFfH9XVPcWxG7YCQRUWC2sX6kMSE3_gLODfA@mail.gmail.com>
 <CAOzgRdYXOgAM+s6OY=eNdg2oJOOTVO6rq+R+PMA6sLyEfm-OdQ@mail.gmail.com>
 <20230510065036.GD1851@quark.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510065036.GD1851@quark.localdomain>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 09, 2023 at 11:50:36PM -0700, Eric Biggers wrote:
> On Wed, May 10, 2023 at 01:47:58PM +0800, youling 257 wrote:
> > I do more test, it is android esdfs or sdcardfs
> > /storage/emulated/0/Android/data problem,
> > "ext4: Stop providing .writepage hook" cause
> > /storage/emulated/0/Android/data/com.android.gallery3d/cache/imgcache.0
> > /storage/emulated/0/Android/data/com.android.gallery3d/cache/imgcache.1
> > /storage/emulated/0/Android/data/com.android.gallery3d/cache/imgcache.idx
> > unable read,
> > 
> > on linux 6.4, i use mount bind data/media on storage/emulated, chmod
> > -R 0777 /data/media/0, rm
> > /storage/emulated/0/Android/data/com.android.gallery3d/cache/*, open
> > gallery app can read pictures thumbnail,
> > /storage/emulated/0/Android/data/com.android.gallery3d/cache/imgcache.idx
> > /storage/emulated/0/Android/data/com.android.gallery3d/cache/imgcache.0
> > /storage/emulated/0/Android/data/com.android.gallery3d/cache/imgcache.1
> > available read.
> 
> Maybe try reverting your commit that added esdfs to your kernel?  It should not
> be needed at all.

Youling, what version of Android are you trying to run with the latest
bleeding edge kernel?  Starting with Android 11, sdcardfs was
deprecated[1].

    SDCardFS is deprecated on devices that launch with Android 11 or
    higher and run kernel version 5.4 or higher. On such devices, VTS
    testing doesn't allow mounted file systems listed as
    SDCardFS. Devices that launch with Android 11 or higher but run
    kernel version 4.19 or lower can continue to use SDCardFS, but
    Google doesn't provide additional support.

[1] https://source.android.com/docs/core/storage/sdcardfs-deprecate

With newer versions of Android, use of something like sdcardfs or
esdfs is not necessary.  If you are using an older version of Android,
and you insist on use a bleeding edge kernel where the writepage is
getting deprecated, then someone will need to update esdfs or deal
with the changing internal interfaces of the upstream kernel.  This is
not the ext4 upstream developer's problem.

Personally, I would recommend that you *not* try to fix esdfs; that's
because stacking file systems like sdcardfs and esdfs are inherently
unreliable.   See the section in [1] entitled, "Why deprecate sdcardfs?".

Instead, what I would recommend is upgrading to a newer version of
Android, and then dropping esdfs from your kernel repository.

	     	  	   	      	   	  - Ted
