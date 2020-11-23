Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224B62C18C9
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Nov 2020 23:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387458AbgKWWrX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 17:47:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731007AbgKWWrW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 23 Nov 2020 17:47:22 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A851206D8;
        Mon, 23 Nov 2020 22:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606171641;
        bh=Y5lt9Kfu9cKXMbpdvDEghaY1aFd4R/Dd0eWL+rbE+FQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KoLFNm9bfa1SYP1O8PRDR3lgq/ZtI86PQbX/7yBT57co9xuKUuCfZ1UVGHkFQJzDr
         GGuwxiNgaEuy12fPquXbCkB0O+2JNLGJ0jsJ/8pQ2e+gl1oSaNc2JmhTWvp6PSGMKL
         NWKwPUnwUajDrxycax/olGUtII0+XixYeMj0yIwU=
Date:   Mon, 23 Nov 2020 16:47:35 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 030/141] ext2: Fix fall-through warnings for Clang
Message-ID: <20201123224735.GI21644@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <73d8ae2d06d639815672ee9ee4550ea4bfa08489.1605896059.git.gustavoars@kernel.org>
 <20201123093709.GB27294@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123093709.GB27294@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 23, 2020 at 10:37:09AM +0100, Jan Kara wrote:
> On Fri 20-11-20 12:28:25, Gustavo A. R. Silva wrote:
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of just letting the code
> > fall through to the next case.
> > 
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thanks. Applied.

Thanks, Jan.
--
Gustavo
