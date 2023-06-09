Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88374728EE1
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jun 2023 06:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbjFIEWu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Jun 2023 00:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFIEWs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Jun 2023 00:22:48 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8631330CF
        for <linux-ext4@vger.kernel.org>; Thu,  8 Jun 2023 21:22:47 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3594MeXV023922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 00:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686284561; bh=34REo61Nl0uQhftBRwVC+HCzlzV7sx/psofbzn5aCz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=e9pfDM3a6Nn5Wikzm3ZKQkXBK5Y0PQkvDcZh/dAHlItZpUmprcsT7uRxNiJICmaLg
         F9Cze5L0AXgW/2a5VM8CxL/nw+zYtoSDXG5CdbFWv0mXX/IBlGMZeLP1fY6I3jDfB8
         XuVcx6Pe6T5MUkW3t+7a5UfDPcYUvFnYcKQDvTfBYgDVQPnBaCaXDSGZxDNhTN3fwO
         Ps0UeOMsyO+aq2ZOXrsi1JpSyA16U24QgJGNv4qG3WB7OpjkofAR0X0kjnZNUBzlvu
         7e6J72BAxzFaqwrRYpg16Mfq4DD6DHcyCOJYBf9GKGW6Kq5a/iBFuzJleysXP6KbCg
         rxS7LURaq5cDg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E9A0915C00B0; Fri,  9 Jun 2023 00:22:39 -0400 (EDT)
Date:   Fri, 9 Jun 2023 00:22:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [e2fsprogs PATCH] resize2fs: use directio when reading superblock
Message-ID: <20230609042239.GA1436857@mit.edu>
References: <20230605225221.GA5737@templeofstupid.com>
 <20230607133909.GA1309044@mit.edu>
 <20230607185041.GA2023@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607185041.GA2023@templeofstupid.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 07, 2023 at 11:50:41AM -0700, Krister Johansen wrote:
> The growpart / resize2fs in the reproducer are essentially verbatim from
> our system provisioning scripts.  Unless those modify the UUID, we're
> not taking any explicit action to do so.

Ah, OK.  OK, I'm guessing that your system provisioning scripts are
attempting mess with the file system a lot (creating, deleting, etc.)
files while trying to run resize2fs in parallel, then?



As far as your patch is concerned, resize2fs can do both off-line
(unmounted) and on-line (mounted) resizes.  And turning direct I/O
unconditionally isn't a great idea for off-line resizes --- it will
really trash the performance of the resize.  Does this patch work for
you instead?

					- Ted

diff --git a/resize/main.c b/resize/main.c
index 94f5ec6d..f914c050 100644
--- a/resize/main.c
+++ b/resize/main.c
@@ -409,6 +409,8 @@ int main (int argc, char ** argv)
 
 	if (!(mount_flags & EXT2_MF_MOUNTED) && !print_min_size)
 		io_flags = EXT2_FLAG_RW | EXT2_FLAG_EXCLUSIVE;
+	if (mount_flags & EXT2_MF_MOUNTED)
+		io_flags |= EXT2_FLAG_DIRECT_IO;
 
 	io_flags |= EXT2_FLAG_64BITS | EXT2_FLAG_THREADS;
 	if (undo_file) {
