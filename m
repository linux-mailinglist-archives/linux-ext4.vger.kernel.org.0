Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8E06F10E7
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Apr 2023 06:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjD1EAz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Apr 2023 00:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjD1EAw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Apr 2023 00:00:52 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6133619BB
        for <linux-ext4@vger.kernel.org>; Thu, 27 Apr 2023 21:00:50 -0700 (PDT)
Received: from letrec.thunk.org ([76.150.80.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33S40KQ9013520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 00:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682654422; bh=rJG4QUYVQuDw+rva/sHAU7EUHGEMW5bSJq1Bth2ZQU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=J1Jd5zfec1WBMNm05X/qSmdzaTxVeaecIiVZ+yhXQpvQusNJBV1XeDAYp/XD0uSff
         SRmwslNx3WpEjyT6FbJDIR6RAiqzJAgq2ErL08yMo/yFw8ikvTCOebO8im0cblhnk0
         HccfC0pEa/vVbmqINyXHfNW5j/1Kzts0Ox1AHzWYEwd+mg5JhUHSoLvVT9A1ijfjNo
         uVjmEtQCP8+0A4DuixGffnQXUr1Ph2gSvJDgny9thd9tdH11J6/kzMtu+uzJXPubny
         vILcmzzWoLAJ1YJluS8K/1c34YV5L0T8SWZ/SUt/FKb5GGCTlmnfxdjgjYdh9X1oTx
         TLE7LoNJ6tD/w==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id A67198C0208; Fri, 28 Apr 2023 00:00:19 -0400 (EDT)
Date:   Fri, 28 Apr 2023 00:00:19 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     adilger.kernel@dilger.ca, yanaijie@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix unused iterator variable warnings
Message-ID: <ZEtE059I5rsxntBu@mit.edu>
References: <20230420-ext4-unused-variables-super-c-v1-1-138b6db6c21c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420-ext4-unused-variables-super-c-v1-1-138b6db6c21c@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 20, 2023 at 09:51:24AM -0700, Nathan Chancellor wrote:
> 
> The kernel has updated to gnu11, allowing the variables to be declared
> within the for loop. Do so to clear up the warnings.

This is OK for this patch, since it's fixing a patch that landed
during this merge window, and it's unlikely this cause problems with
any future security patches that will need to be backported into 5.15,
5.10, etc. --- or result in patch conflicts that will be any worse
than what we already have.

However, for anything that might be something that needs to be
backported into LTS kernels, or be in code that might get be involved
with a LTS backport patch, let's not use any C11/GNU11 whenever
possible.

						- Ted
