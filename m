Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5596A15A3
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Feb 2023 04:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjBXDr3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Feb 2023 22:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjBXDr1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Feb 2023 22:47:27 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B6D18156
        for <linux-ext4@vger.kernel.org>; Thu, 23 Feb 2023 19:47:25 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31O3l5nE024755
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 22:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677210427; bh=gcV/wYaz3HRVhPFqucHiyHMedCnejIoiYsMCljXnJFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=p8ucGDf8UV0PT1F5phYoN4L2YSghzsB/P993Ha9fNgCTF5wRleDA0L8ciK+b4SOI1
         3qJcyBgR07CmAkoTvwXwrbaEPLt6CSxY14ZM6yj5iw6ip+YI/Yy9JebPFEET00Q3qx
         qmdE4DZ6ehr3AavY73lOXJE5prItS4SsjO0qvVAN+PujD+9o9boMN0KH8G+bz460Fq
         qYSaasGu0fkdoZFN336FmdDmw2EYRF28EoZlGKWp9D5ahp8DpSv0bTxhhiN4N6zaVa
         UybimAHLgbqOm2SdYmAgDrkbqzoXagwWbFkbQqefaT1U5tlM0w1EpmNTbAnZi2Ru/y
         MNPhVX/wk4SXg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3DBD215C3511; Thu, 23 Feb 2023 22:47:05 -0500 (EST)
Date:   Thu, 23 Feb 2023 22:47:05 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linfeilong@huawei.com,
        louhongxiang@huawei.com
Subject: Re: [PATCH v2] lib/ext2fs: add some msg for io error
Message-ID: <Y/gzOSmW70rXcjvq@mit.edu>
References: <20230223090111.680573-1-zhanchengbin1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223090111.680573-1-zhanchengbin1@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 23, 2023 at 05:01:11PM +0800, zhanchengbin wrote:
> Add msgs to show whether there is eio in fsck process, when write and
> fsync methods fail.
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>

The libext2fs is a *library*.  As such, well designed libraries do not
randomly write to stderr.  Consider what might happen if there was a
curses based program that was calling libext2fs --- for example, like
the ext2ed program.  Writing random errors to stderr is just *rude*.   :-)

If what you're worried about errors from e2fsck, it's also not
necessary, since that's what the error handler callback is for.

Cheers,

					- Ted
