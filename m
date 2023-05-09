Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FB86FBE7B
	for <lists+linux-ext4@lfdr.de>; Tue,  9 May 2023 07:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjEIFCc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 May 2023 01:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEIFCb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 May 2023 01:02:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08AF468B
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 22:02:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E95663024
        for <linux-ext4@vger.kernel.org>; Tue,  9 May 2023 05:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BF9C433EF;
        Tue,  9 May 2023 05:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683608549;
        bh=QEnLAg6KWmmWaE0QCgUpcv95BgAw7b19p9B/qGObCw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HJYP+uAi2vRwXqW5kl6xLiV1L6oR0fXEA5fKSHZRQmhkO3MyWLvOxsmz8c53oWjNn
         IchXb3JjMpV6jA+j21MP67zL8HCiJ1BtFfYpu+CW+qWMmsXet86gbs4tg+1RD0afuD
         NZiwGj55xwaYZW9ERtlDwsJaw6fUR4cLkku0kENjmjJcsX6fuvMMUku+ozzBYlHaRA
         mlUC1aHyIK2Kb5levfotVfbTP9k+EJF5TocsztsV6ORSOj1lcn8Lq95lOS9vUNbGC/
         /NXDqNBiHgiPiBF0VdpUBpVGUZlom6fqV280fM6leWloOo7FLIB+RwYaH80ieEFejV
         T8vCG/tqZ/uyA==
Date:   Mon, 8 May 2023 22:02:27 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     youling257 <youling257@gmail.com>
Cc:     jack@suse.cz, hch@infradead.org, hch@lst.de,
        linux-ext4@vger.kernel.org, ritesh.list@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v4 12/13] ext4: Stop providing .writepage hook
Message-ID: <20230509050227.GA1180@quark.localdomain>
References: <20221207112722.22220-12-jack@suse.cz>
 <20230508175108.6986-1-youling257@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508175108.6986-1-youling257@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 09, 2023 at 01:51:08AM +0800, youling257 wrote:
> I using linux mainline kernel on android. https://github.com/youling257/android-mainline/commits/6.4  https://github.com/youling257/android-mainline/commits/6.3
> "ext4: Stop providing .writepage hook" cause some android app unable to read storage/emulated/0 files, i need to say android esdfs file system storage/emulated is ext4 data/media bind mount.
> I want to ask, why android storage/emulated need .writepage hook?

"esdfs" doesn't exist upstream, so linux-ext4 can't provide support for it.

Also, it doesn't exist in the Android Common Kernels either, so the Android team
cannot help you either.

- Eric
