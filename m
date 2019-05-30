Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8992F75D
	for <lists+linux-ext4@lfdr.de>; Thu, 30 May 2019 08:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfE3GEf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 May 2019 02:04:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3GEf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 May 2019 02:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ukdzhaLkbFrU+94WV3nmOVSVdvK3CFipHYlKptliEno=; b=KJ8Fy06NSZFpqC94Gnwq0Go6+
        5z5XOMjY9VHg4BSrttOMxLs3GFjpJU69L8I2Zp7vro8Ccv0GWoMM4aK+z7b/fJr058JEZQKHyZF6M
        TXWkOo9osOhfy3/oxT4T6tBqNwVSpNXHSwYviKcveIhO/CHym72LFarerzzOe7Zw4XcE+nzLI/50h
        lMzp06S/deuQ73KU0/9OjoTyayJD8JfIzpy/R0dmeYDaSpo8RwQ/UoUWBzNl/o5mRrDJhESq6b7hx
        XnB5l2dI2P0BqpTNVonyRyzsPSzOWUVlA6uDm269+82/Tq4rEnGX/pQwemO/EAgvuST+Z1Y73Rj4m
        DGWcurRLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWEAs-0008Ap-7A; Thu, 30 May 2019 06:04:26 +0000
Date:   Wed, 29 May 2019 23:04:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        xfs <linux-xfs@vger.kernel.org>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: How to package e2scrub
Message-ID: <20190530060426.GA30438@infradead.org>
References: <20190529120603.xuet53xgs6ahfvpl@work>
 <20190529182111.GA5220@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529182111.GA5220@magnolia>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 29, 2019 at 11:21:11AM -0700, Darrick J. Wong wrote:
> Indeed.  Eric picked "xfsprogs-xfs_scrub" for Rawhide, though I find
> that name to be very clunky and would have preferred "xfs_scrub".

Why not just xfs-scrub?
