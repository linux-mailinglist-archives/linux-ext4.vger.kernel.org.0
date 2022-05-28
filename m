Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A626F536A3C
	for <lists+linux-ext4@lfdr.de>; Sat, 28 May 2022 04:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352706AbiE1CbR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 May 2022 22:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiE1CbQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 May 2022 22:31:16 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33760B0C
        for <linux-ext4@vger.kernel.org>; Fri, 27 May 2022 19:31:14 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24S2V8Ew019947
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 22:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1653705069; bh=Z1u6ON107qcZpMZtGHhGQiIlGB+ni4YayX1wyfjEFM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dgWIQM9tuiD691xWB8GYw2UYZAjhx2d/v2meebN6dS/jk7mv13r8TD7L7LFCFwfd5
         P4CN112WLz6Zcu69IwM+zbu7o5w30hqmFM6+WBwuin1Z7T7miAxEhaehkXePkjcGCs
         RT1FufnibIfM2lgcyw7k5Wxv6pWaiQ8ouAyeu7DB1885TzlzwMXCkkXaxQ65usSv9g
         HCiXfNF2f17CjeUMxZNLsmtlBLQM0mRR/DBgqXCLvRCBN9pi+TbYEBD4IyFDgJBgOZ
         uUXDEL6ofOGeH5pUsfFc4FMh0WjUha2AMhCOB/f+U45hxCzRI308ypWO4X5g3GgPIz
         jT00xgwGdi35A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CFCB315C009C; Fri, 27 May 2022 22:31:07 -0400 (EDT)
Date:   Fri, 27 May 2022 22:31:07 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Kiselev, Oleg" <okiselev@amazon.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: Does `-O bigalloc` still conflict with `delalloc`?
Message-ID: <YpGJa/f3dSh2XZwb@mit.edu>
References: <923065C9-2EFB-4F59-895E-139B4B9F9E98@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <923065C9-2EFB-4F59-895E-139B4B9F9E98@amazon.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, May 21, 2022 at 02:39:00AM +0000, Kiselev, Oleg wrote:
> The `ext4(5)` man page, contained in the most recent e2fsprogs still says:
> 
> 	Warning: The bigalloc feature is still under development, and may not be fully  supported
>               with your kernel or may have various bugs.  Please see the web page http://ext4.wiki.ker‐
>               nel.org/index.php/Bigalloc for details.  May clash with delayed allocation (see  nodelal‐
>               loc mount option).
> 
> Is a bad interaction with `delalloc` still an issue and should we be using the `nodelalloc` option?

Apologies for not getting back to you right away.  I wanted to check
with some folks on the ext4 team, and in fact we talked about it at
this week's ext4 video chat.  Eric Whitney worked on fixing bigalloc
and delalloc, and it looks like the last of the fixes landed in Linux
version 5.4 in 2019.  So that warning in the ext4(5) man page is
definitely out of date.

I'll remove it in the next release of e2fsprogs.

Cheers,

					- Ted
