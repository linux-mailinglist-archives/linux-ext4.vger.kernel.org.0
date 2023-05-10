Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A5C6FD766
	for <lists+linux-ext4@lfdr.de>; Wed, 10 May 2023 08:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjEJGum (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 May 2023 02:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbjEJGuk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 May 2023 02:50:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBF7268D
        for <linux-ext4@vger.kernel.org>; Tue,  9 May 2023 23:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0B97639AB
        for <linux-ext4@vger.kernel.org>; Wed, 10 May 2023 06:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB66C433EF;
        Wed, 10 May 2023 06:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683701437;
        bh=HzYliJcxoAQC0s/j5n11YH8eHx0e5/qRksG+erRriLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lE854Ka4kaG7nDjXR/RiF/m9jsEEl/BMwQ8nR98glqI2QlL3xMP3RSPIf9VmG7HA6
         hj30NOjOocvSBFw23XMw06YTbgQyrMo72v7+RaMoZH8T/Pyu6txZZfMn4CnuoRimjk
         MACRTT5pB/OAjfvgu2kao1Hs4Y04B18V8XQsJOfgOAJ2vMhhh2RSDCGqbeQ0sVGJmk
         bh3R/KyL57LxPzP4sgIyxVaYVpm3TF2tcXUmwUJt6gd2NYQGPnVWP9TjN61u7Fc72Y
         itahVsW1WG17+9cZBPnMNx1I4BxetHpiHucBpihBGDuFavxAzqzNkC1a53V5AgLcIB
         r1a5BNQ5U3t7Q==
Date:   Tue, 9 May 2023 23:50:36 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     youling 257 <youling257@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, jack@suse.cz, hch@infradead.org,
        hch@lst.de, linux-ext4@vger.kernel.org, ritesh.list@gmail.com,
        keescook@chromium.org
Subject: Re: [PATCH v4 12/13] ext4: Stop providing .writepage hook
Message-ID: <20230510065036.GD1851@quark.localdomain>
References: <20221207112722.22220-12-jack@suse.cz>
 <20230508175108.6986-1-youling257@gmail.com>
 <20230509050227.GA1180@quark.localdomain>
 <ZFqSwegsnsqi3vAu@mit.edu>
 <CAOzgRdbkno+k1_vFfH9XVPcWxG7YCQRUWC2sX6kMSE3_gLODfA@mail.gmail.com>
 <CAOzgRdYXOgAM+s6OY=eNdg2oJOOTVO6rq+R+PMA6sLyEfm-OdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOzgRdYXOgAM+s6OY=eNdg2oJOOTVO6rq+R+PMA6sLyEfm-OdQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 10, 2023 at 01:47:58PM +0800, youling 257 wrote:
> I do more test, it is android esdfs or sdcardfs
> /storage/emulated/0/Android/data problem,
> "ext4: Stop providing .writepage hook" cause
> /storage/emulated/0/Android/data/com.android.gallery3d/cache/imgcache.0
> /storage/emulated/0/Android/data/com.android.gallery3d/cache/imgcache.1
> /storage/emulated/0/Android/data/com.android.gallery3d/cache/imgcache.idx
> unable read,
> 
> on linux 6.4, i use mount bind data/media on storage/emulated, chmod
> -R 0777 /data/media/0, rm
> /storage/emulated/0/Android/data/com.android.gallery3d/cache/*, open
> gallery app can read pictures thumbnail,
> /storage/emulated/0/Android/data/com.android.gallery3d/cache/imgcache.idx
> /storage/emulated/0/Android/data/com.android.gallery3d/cache/imgcache.0
> /storage/emulated/0/Android/data/com.android.gallery3d/cache/imgcache.1
> available read.

Maybe try reverting your commit that added esdfs to your kernel?  It should not
be needed at all.

- Eric
