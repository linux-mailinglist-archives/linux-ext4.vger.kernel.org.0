Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31035374FEB
	for <lists+linux-ext4@lfdr.de>; Thu,  6 May 2021 09:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbhEFHUB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 May 2021 03:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhEFHUA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 May 2021 03:20:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27615C061574
        for <linux-ext4@vger.kernel.org>; Thu,  6 May 2021 00:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7vJ29roYHGe97kqrGtKhXmkCGEDSMicp13LSjdLKcok=; b=pkzqb91kMkW7wHP0qGY4/ASYrf
        X2YCkAh2nnq46gsdjVHfYpgx++5Jcsv1oW2T7KIzNwvqOL+c6PdbSLVd/GN/OR0oAEv8buYwUJl4T
        ylChvWBg8Vd00/r0Zeg+WAWgDO7neHs0cKyUpwj0hArADszuxSG5qU/ujGUeD3reiVDAP4hTI+AR8
        oQSv4VqEeUL3D8jpMMpB9qCaz7tD2+k8d7VA4jgBqrRBfqFjEmVpfr6BOGSCCsIgS5PaQz+btx7ZQ
        dFUiQa82G2ezt8TUQDwf/P0EUpzqPhUnwTxTN64ervY916ubQBRiFlfBvtI4j1eXTroHjyMa6YoSF
        YK2ITj2g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leYHM-001Q0a-VJ; Thu, 06 May 2021 07:18:50 +0000
Date:   Thu, 6 May 2021 08:18:36 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH v3 2/3] ext4: add ioctl EXT4_IOC_CHECKPOINT
Message-ID: <20210506071836.GA337144@infradead.org>
References: <20210504163550.1486337-1-leah.rumancik@gmail.com>
 <20210504163550.1486337-2-leah.rumancik@gmail.com>
 <20210505212711.GA8532@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505212711.GA8532@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 05, 2021 at 02:27:11PM -0700, Darrick J. Wong wrote:
> Er... what specifically does "data" mean?  File data, or just the dirent
> blocks?
> 
> I think this is only true if discard_zeroes_data == 1, right?  The last
> I looked, ext4 was calling REQ_OP_DISCARD, not REQ_OP_WRITE_ZEROES.
> 
> Also, there are some SSDs that "implement" discard as nop, which means
> that the old contents can still be read by re-reading the LBAs.  What
> about those?

Not just some, but most at least for corner cases.  ATA TRIM, SCSI UNMAP
and NVMe Deallocate all explicitly allow for keeping some of the old
data, and devices make use of that when the discard requests does not
map to their internal granularities.

> (Also wondering if this is where FS_SECRM_FL files should get their
> freed file blocks erased with REQ_OP_SECURE_ERASE...)

Only implemented for mmc..
