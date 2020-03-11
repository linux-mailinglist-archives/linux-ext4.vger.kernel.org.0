Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE73D1810D2
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Mar 2020 07:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgCKGeF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Mar 2020 02:34:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52144 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgCKGeF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Mar 2020 02:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=PXWJMkmYQZtzBqa9T6Z/OooTHl
        iLs9oLlg6UBOsvnoharqwzOsHoLebB9KBGfGmMc42QR+rRzOtEAsIu7Js0uSfsCsPluEjZEY4gm+T
        yRWZ6YCPEuyAOvYHMqhZ8CDu1T9iGjvnV36RcZHcp55Nnjj7Hds0A2BhzBLV1i4w6vgV6yleZ3fdt
        sOj29SBcRXElRDCQvqk2ez4+996Vsp0e4tX/laNomiHC/I3xHXfKk47l5DDsd2md1mcWpKIJI38AI
        y97/mDjGFzH0W15VdZZrSBeo922COCKsiN6sg/hXF+Dx3iRDQvGZNd6ZuhfU2V8Wfr8uV9RtCQ57h
        qFwBKxBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jBuwP-0005Ba-7P; Wed, 11 Mar 2020 06:34:05 +0000
Date:   Tue, 10 Mar 2020 23:34:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] xfs: clear PF_MEMALLOC before exiting xfsaild thread
Message-ID: <20200311063405.GA13368@infradead.org>
References: <20200309181332.GJ1752567@magnolia>
 <20200309185714.42850-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309185714.42850-1-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
