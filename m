Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0607E6D73D1
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 07:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbjDEFlE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 01:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbjDEFlD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 01:41:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A494421F;
        Tue,  4 Apr 2023 22:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tUw6fLkEufjZAV2DxCfgThpnp199F0064DabhqHL5gY=; b=CtwY0kfoOx7fpitUqNyr2agKf5
        Cwc+0wCG3Oxocf/8h3JXDkzFPp5B0vdMeQwuolA/yIbAGfRHelbWKdHE4Rv3eDXhv5HPMRlvLZSwo
        MGZmh6BIvUqNjIatQ+Eq4PULjw+uH3Rwlvm4Se76CfTDMBHlMjTKTwrLh7jW4u/OYbUY8g0DHq34H
        /gyv+aBD8abMtGVudmOa5kyQrTlTF+4OH/VJkTOx167a26hE7ueNoimzIZGVJVfYlKSYJWxaQ1UcL
        chWvg9htMHVrIE+BMGgs8ybczCztsE/FRZC17U0pmMIaB9Wl0OZAQvNtnX5T9xy7E3VdRbmcLs3xc
        ANsBEzkg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjvtA-003Pme-1h;
        Wed, 05 Apr 2023 05:40:56 +0000
Date:   Tue, 4 Apr 2023 22:40:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     wuchi <wuchi.zero@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: simplify 32bit calculation of lblk
Message-ID: <ZC0J6I1pYNZBB30y@infradead.org>
References: <20230403135304.19858-1-wuchi.zero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403135304.19858-1-wuchi.zero@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 03, 2023 at 09:53:04PM +0800, wuchi wrote:
> -			if (block > ext_block)
> -				return ext_pblk + (block - ext_block);
> -			else
> -				return ext_pblk - (ext_block - block);
> +			return ext_pblk + ((signed long long)block - (signed long long)ext_block);

And what exactly is the value add here, except for turning an easy
to parse statement into a complex expression using casts?

