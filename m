Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287926471A9
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Dec 2022 15:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiLHOZj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Dec 2022 09:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiLHOZL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Dec 2022 09:25:11 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C76C98E9B
        for <linux-ext4@vger.kernel.org>; Thu,  8 Dec 2022 06:24:17 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2B8ENuQI025793
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Dec 2022 09:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1670509439; bh=YwhhXqgVcc5M96wp3X5fvuY/6lNUUIfGs0Ta8coLnPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=hzeGc8gZ7mB3uLJtIa/FUcsbHu5cYuuCBWbr0mBAYamAxuGOO1WenUkk3370Z2m2L
         amYHg3vGtDNAyt+sRX+ctCT7eUhvWXa4oHIoOaFCkcuLuPaEJmS+kcBkdaloxwpSVP
         +eeAVkj8wCeRinzp7UvNymMAzr33iqxCXtB/oVNmAD3DdMhtcl3D3r3mrp/8J0wDTs
         h6sOqoxDOApfu0F+paPChE7kko8YQUyFUZL030QPGvBA2kJpuGYNniRlTB0a/r3Fpt
         Jy4FjUIIdfKOJd86nuCP3WTWHIZpgsa5Xem69BZYnLwcbMRBCGtu6N5pRRbJLYCjTM
         OGe7tXn5KaHhw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2E5A415C39E4; Thu,  8 Dec 2022 09:23:56 -0500 (EST)
Date:   Thu, 8 Dec 2022 09:23:56 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 13/13] ext4: Remove ordered data support from
 ext4_writepage()
Message-ID: <Y5HzfGolIoH5PTXn@mit.edu>
References: <20221207112259.8143-1-jack@suse.cz>
 <20221207112722.22220-13-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207112722.22220-13-jack@suse.cz>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 07, 2022 at 12:27:16PM +0100, Jan Kara wrote:
> ext4_writepage() should not be called for ordered data anymore. Remove
> support for it from the function.
> 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>

This commit (determined via bisection) is causing a large number of
test failures for ext4/data_journal case:

ext4/data_journal: 521 tests, 33 failures, 98 skipped, 4248 seconds
  Failures: ext4/004 generic/012 generic/016 generic/021 generic/022 
    generic/029 generic/030 generic/031 generic/032 generic/058 
    generic/060 generic/061 generic/063 generic/071 generic/075 
    generic/098 generic/112 generic/127 generic/231 generic/393 
    generic/397 generic/404 generic/439 generic/455 generic/477 
    generic/491 generic/567 generic/572 generic/574 generic/577 
    generic/634 generic/639 generic/679

Many/most of these failures appear to be data plane failures.  For
example ext4/004 is a "dump | restore" followed by a "diff -r
$DUMP_DIR $RESTORE_DIR".  The generic/012, generic/021, generic/022
failures are md5sum checksum failures after testing the punch hole
operation.  The generic/029 failure are hexdump mismatches after
calling a combination of truncate, pwrites, and mmap'ed writes, etc.

Since this is the last patch in the series, and we've already dropped
the writepage hook (which is one of the things Christoph was going
for), so one approach might be drop this patch from the series at
least for this upcoming merge window.

Jan, what do you think?

					- Ted
