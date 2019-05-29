Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13B8F2D5C6
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2019 08:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfE2G4v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 May 2019 02:56:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35340 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfE2G4v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 May 2019 02:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xy/XIwjmIFCgclxo6NMMP4he3jCcIbmaHoeiaUStrCw=; b=sF4PTQsw/jy7WWcotv36VJ99m
        0DFf92y9jdX1377myhMyIx2nlEnwyzTkk+/dBhbvkFIXRlc/h/Mwves4DgPncCG9yrJ9YDTW1F0KJ
        mW93LBneSVfvDnxBIjHHx+57NsqZDWbs9p9qO68ESHqiACp6sKqbDqnpiVwKiblzPZf2K//sZ/Fe0
        Kw7TPH8G5AgyVvO22xQWFhb3DZJRxm7hS1jigO2bN9xF8XENJGn/aYkHG+fx9TunI9gpzoDdrOkx9
        nkswLu8Uh1Or256ibMJcIVJxzziMnwCC45FssQoDYGref4hEoU9xbHCFL6vRG8ROxlYRR62PWKA+A
        x5ODNWEcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVsVz-0003Qg-QI; Wed, 29 May 2019 06:56:47 +0000
Date:   Tue, 28 May 2019 23:56:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: fsync_mode mount option for ext4
Message-ID: <20190529065647.GA8405@infradead.org>
References: <20190528032257.GF10043@codeaurora.org>
 <20190528034007.GA19149@mit.edu>
 <20190528034830.GH10043@codeaurora.org>
 <20190528131356.GB19149@mit.edu>
 <20190529040757.GI10043@codeaurora.org>
 <20190529052332.GB6210@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529052332.GB6210@mit.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 29, 2019 at 01:23:32AM -0400, Theodore Ts'o wrote:
> If you have protection against sudden shutdown, then nobarrier is
> perfectly safe --- which is to say, if it is guaranteed that any
> writes sent to device will be persisted after a crash, then nobarrier
> is perfectly safe.  So for example, if you are using ext4 connected to
> a million dollar EMC Storage Array, which has battery backup, using
> nobarrier is perfectly safe.

And while we had a few oddities in the past in general any such device
will obviously not claim to even have a volatile write cache, so
nobarrier or this broken proposed mount option won't actually make any
difference.
