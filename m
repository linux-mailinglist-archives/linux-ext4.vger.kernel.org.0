Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B81281213
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Oct 2020 14:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbgJBMPm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Oct 2020 08:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBMPl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Oct 2020 08:15:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2536C0613D0
        for <linux-ext4@vger.kernel.org>; Fri,  2 Oct 2020 05:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CR8e49YKlesaisZe6dO4zC/e//OYRkzLpTss7IU3TsI=; b=Qw9UL72CLtISVIGDEJxF9J8l4p
        xslqqtb6guKmZgswi3N+QGQOCDrYX8vgqrIBoD4o4etOxrwDi5wCUsqBbSygr/n6FupAdhypj8eXw
        kydD5BxjXf0ATPV7oMc7I9G5Or2SY4+q3lRva3HVsElC1iGbgOqTBS+wxoLOa696UT8iOCY8/4bej
        hK57RM+hvKD6l2R/mEntNjj+judgSP3bI1/Fqicog77y9mgT5c5Jb6vnSKdJKxaLoT5Os2g4GGEbV
        PAROse3RwPstb2M61Q0XAbNBUFVquxKjHBIQrjHvrvzeCSxpfnCFEVkwiYmPsj3N/xvCW8gRAOoZI
        QmIr4C7g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOJyH-0002vz-Bq; Fri, 02 Oct 2020 12:15:33 +0000
Date:   Fri, 2 Oct 2020 13:15:33 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org
Subject: Re: State of dump utility
Message-ID: <20201002121533.GA10559@infradead.org>
References: <20200929143713.ttu2vvhq22ulslwf@work>
 <20200930020646.GD23474@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930020646.GD23474@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 29, 2020 at 10:06:46PM -0400, Theodore Y. Ts'o wrote:
> One of the interesting questions is how reliable the dump utility
> really is; that's because it works by reading the metadata directly
> --- while the file system is mounted.  So it's quite possible for the
> metadata to be changing out from under the dump/restore process.
> Especially with metadata checksums, I suspect dump/restore is going
> much more unreliable in terms of the libext2fs returning checksum
> failures.

Before using a tool like dumpe2fs you'll need to do a fsfreeze,
and then everything should be fine.  Best would be to patch the
tool to issue the freeze/unfreeze ioctls itself.
