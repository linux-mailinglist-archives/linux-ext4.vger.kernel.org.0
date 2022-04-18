Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF24505FC3
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Apr 2022 00:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiDRWaD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Apr 2022 18:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiDRWaC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Apr 2022 18:30:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECB32AC41;
        Mon, 18 Apr 2022 15:27:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61141B81132;
        Mon, 18 Apr 2022 22:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900BFC385A1;
        Mon, 18 Apr 2022 22:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650320838;
        bh=dM3ozRl9eZA2yxR6eKEJTWs0R0k8qCfJ/KyhnkH7+UI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vFVIE3TDPIXRofyOutK/iiDDJvLWCeB1V28Dpv/eLvcmse+ZVernBWfUXs1Hlmc0q
         SOgpGy8bErqGieFJJBpKG3WgESm5RAeU8gKpoh7wfqjpe0o6azfwRfRSZzNIZEORPW
         CJw2tkxuRenbJDp+QAAsDyGogUcpkq0KE+Ad9RakjnT8SCg8wuvkNf/HT4qddF3mcp
         5HABppW5duQ82yb5mhCEdwLyRfuoqKWIX9zegozdKNssmKY5+qL59k65/YrOO8L15R
         CtS9la+pn37pNHrFnJ2icbrEwB6AgKgXZNl9lugSNKwNsJegCyVDwcdrW9YRaxvE4i
         F82XBZ0ouUZFQ==
Date:   Mon, 18 Apr 2022 15:27:16 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     =?utf-8?B?5bi45Yek5qWg?= <changfengnan@vivo.com>
Cc:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH 2/3] f2fs: notify when device not supprt inlinecrypt
Message-ID: <Yl3lxMnZ5teL+bkU@sol.localdomain>
References: <20220418063312.63181-1-changfengnan@vivo.com>
 <20220418063312.63181-2-changfengnan@vivo.com>
 <Yl0RmUoZypbVmayj@sol.localdomain>
 <KL1PR0601MB400369725474F2A2DE647057BBF39@KL1PR0601MB4003.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <KL1PR0601MB400369725474F2A2DE647057BBF39@KL1PR0601MB4003.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 18, 2022 at 07:34:52AM +0000, 常凤楠 wrote:
> > -----Original Message-----
> > From: Eric Biggers <ebiggers@kernel.org>
> > Sent: Monday, April 18, 2022 3:22 PM
> > To: 常凤楠 <changfengnan@vivo.com>
> > Cc: jaegeuk@kernel.org; chao@kernel.org; tytso@mit.edu;
> > adilger.kernel@dilger.ca; axboe@kernel.dk; linux-block@vger.kernel.org;
> > linux-ext4@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > Subject: Re: [PATCH 2/3] f2fs: notify when device not supprt inlinecrypt
> > 
> > On Mon, Apr 18, 2022 at 02:33:11PM +0800, Fengnan Chang via
> > Linux-f2fs-devel wrote:
> > > Notify when mount filesystem with -o inlinecrypt option, but the
> > > device not support inlinecrypt.
> > >
> > > Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> > 
> > You didn't include a cover letter in this patchset.  Can you explain what
> > problem this patchset is meant to solve?
> 
> What I'm try to make is when devices not support inlinecrypt, do not show inlinecrypt in mount option. 
> When I test fscrypt first, it make me confused. Not a real problem, just make this logical more reasonable.
> Do you think this needs to be revised?

Well, I'm just not sure we should do this, or at least by itself, given that
support for inline encryption is not an either-or thing, and the inlinecrypt
mount option is already documented to apply only to files where inline
encryption can be used.  See Documentation/filesystems/fscrypt.rst:

	Note that the "inlinecrypt" mount option just specifies to use inline
	encryption when possible; it doesn't force its use.  fscrypt will
	still fall back to using the kernel crypto API on files where the
	inline encryption hardware doesn't have the needed crypto capabilities
	(e.g. support for the needed encryption algorithm and data unit size)
	and where blk-crypto-fallback is unusable.  (For blk-crypto-fallback
	to be usable, it must be enabled in the kernel configuration with
	CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y.)

And Documentation/admin-guide/ext4.rst and Documentation/filesystems/f2fs.rst:

	When possible, encrypt/decrypt the contents of encrypted files using the
	blk-crypto framework rather than filesystem-layer encryption. ...

If we do want to warn when inlinecrypt is given but inline encryption cannot be
used, your patchset isn't enough since it only covers the case where no form of
inline encryption is available at all, and not the case where some form of
inline encryption is available but the filesystem can't use it.

- Eric
