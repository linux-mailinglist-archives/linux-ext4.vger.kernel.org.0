Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4568879C3D9
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Sep 2023 05:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242191AbjILDQB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Sep 2023 23:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242372AbjILDPr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Sep 2023 23:15:47 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0BB9C0A7
        for <linux-ext4@vger.kernel.org>; Mon, 11 Sep 2023 18:50:06 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-113-225.bstnma.fios.verizon.net [173.48.113.225])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 38C1nuOT011233
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 21:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1694483399; bh=s/sNfzwYevk+Y0pvlAXrndruCaAI/NMq2RHWu1p5lv0=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=FCbGFjdTCqBv1956viEFvp2wv86UD1iScNuz6Q63doqVjOLJ3zpQP/sC4hpqG5SmH
         nmPbYmlTMOvOKtQYbQwPKnk7NMTlECWJ5x/aYm1853ZmTW0wAvhB4EtNcRMPZVoC8X
         3d5kq+7g6K2QOQZkXPhI0Wy//cIXCfIojEd5I6DY8D/kwcl9UtNZk00+HVjRfhBfkp
         aSHloMt2Sg85HW54Re4oiyc8LD9YHVJbtfh/a8gyK3fHNxR+/kQ2o2OIABv4G2WOlj
         etSRCZu5Eg8lwZz5N53EhGeAdjy1iS8EyZLwPc9NmTSlfFHXMirIx8Xv2P+rjbcIeY
         uvcw7Pi5bwjGA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 855F615C023F; Mon, 11 Sep 2023 21:49:56 -0400 (EDT)
Date:   Mon, 11 Sep 2023 21:49:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Dave Kleikamp <shaggy@austin.ibm.com>,
        Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix a test in ext4_decode_error()
Message-ID: <20230912014956.GB1182921@mit.edu>
References: <2c0edffd8557807c6cd6d55111482c5cad7c8f2f.1694275603.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c0edffd8557807c6cd6d55111482c5cad7c8f2f.1694275603.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Sep 09, 2023 at 06:07:02PM +0200, Christophe JAILLET wrote:
> The doc of snprintf() states that "If the return is greater than or equal
> to @size, the resulting string is truncated".
> 
> So in order to "Check for truncated error codes...", we must check that the
> returned value is < 16.
> 
> Fixes: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

This patch is not needed.  It's fine if snprintf truncates the string,
since it will still be null terminated.  This was checking for the
case where snprintf() returns an error, and the comment was
misleading.

Looking that the current implementation of the kernel snprintf, it
will never return a negative number, and nbuf is always passed in from
the callers, so it could be changed to

		snprintf(nbuf, 16, "error %d", -errno);
		errstr = nbuf;
		
But what is currently there is certainly valid.

						- Ted
