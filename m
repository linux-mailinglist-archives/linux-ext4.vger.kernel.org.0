Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427ED1F13A4
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Jun 2020 09:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgFHHf3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Jun 2020 03:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgFHHf3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Jun 2020 03:35:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163DBC08C5C3
        for <linux-ext4@vger.kernel.org>; Mon,  8 Jun 2020 00:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eHfpjh891ityA1r16jHV1vsZMAo/p7LTBegBhzSrTzo=; b=iSD2Wguzd2J17KjjN18SI+Y1RJ
        cvdta+ufkDyDqzWSBY1l6q/rpdm1O+mva5l7pyex3R6dyl1lJCiQ4/8dpqkKjxYf1Moox1cMWpLdb
        NTnQO/tpgb8Wk4u5bh0DpfBat7p2sxicAxNc5pT5VvbBCTSFhXjtsCHfFDfbfvd+2omyXsu4sRTP6
        tF6AMm+yhCiBlTsJzQxsA3+qywxa38bTM72DMOfdDewy+AzD/xp2tTiAuFLePjonE44ZTD+dKn+29
        Za3Lm2tRjwIk8zCz17ZZU9Zzb761ZZN6IrlDZC7t8qJ+cqyNeOI8qWj5kAOD0Fzvn3BW4c+ZFqBDw
        OtR7+a1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiCJY-0002q0-Fu; Mon, 08 Jun 2020 07:35:24 +0000
Date:   Mon, 8 Jun 2020 00:35:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: issue aligned discards
Message-ID: <20200608073524.GA1480@infradead.org>
References: <20200605222819.19762-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605222819.19762-1-harshadshirwadkar@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 05, 2020 at 03:28:19PM -0700, Harshad Shirwadkar wrote:
> Ext4 before this patch can issue discards without respecting block
> device's discard alignment. Such a discard results in EIO and
> kernel logs.

No, that is not how discard works.  The granularity is a hint and
blk_bio_discard_split already does all the work to align to it.  If
you have a make_request based driver that doesn't do that you need
to fix that driver instead.
