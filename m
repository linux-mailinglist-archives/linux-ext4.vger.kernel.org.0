Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8FF6822A8
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Jan 2023 04:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjAaDNy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Jan 2023 22:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjAaDNp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Jan 2023 22:13:45 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A855BF740
        for <linux-ext4@vger.kernel.org>; Mon, 30 Jan 2023 19:13:14 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30V3CiYh013236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 22:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1675134765; bh=Y3yqB0tpY18RVTzG1azKoVPV3LHN2h3tqhK7YByPirE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=pw+8wS3dDnELQgphzr6N1p1AR//3lZBDC3EwBLOiD4uMIoCCJr1qn30oNRd1/xIxa
         SuDSpUHAWEhiGQBgdAgA4NcxIMaDCPGjIXiz+dMRbP9K2FiheNnApcjIbweRytW/qR
         KKqzYi2luQ0TRvUx8+NvRjzE88s4pXYLfskRkbb29ncz7YtwuYmizDHcCBg3g2D2lO
         59AVcO5LuFv+a/FdBlnG17Z3pI/EK4wTmwzOe4LY8uFNz+GMeNrwObq//DkM7r8edH
         QA1uEAOhDVmpgiWYKazye3/iP6e8DdHqCPA8EQAt5n42VDoF7FCCZ5LY17RHQV2t+H
         mYeiag1Yf+aBA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E32C915C359D; Mon, 30 Jan 2023 22:12:43 -0500 (EST)
Date:   Mon, 30 Jan 2023 22:12:43 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linfeilong <linfeilong@huawei.com>,
        liuzhiqiang26@huawei.com
Subject: Re: [PATCH] unix_io.c: fix deadlock problem in unix_write_blk64
Message-ID: <Y9iHKxQ8jszr+/g4@mit.edu>
References: <310fb77f-dfed-1196-c4ee-30d5138ee5a2@huawei.com>
 <Y9DJnh9P+FijguS2@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9DJnh9P+FijguS2@mit.edu>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 25, 2023 at 01:18:06AM -0500, Theodore Ts'o wrote:
> 
> Fortunately, we're safe on the read side, because we currently very
> carefully do not call raw_read_blk() while holding the CACHE_MUTEX.
> Instead, we write the data from the user-supplied buffer, and *then*
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> take the cache mutex, and then save the data from the user-supplied
> buffer into the cache.

Correction: the last sentence of this paragraph should begin:

"Instead, we READ the data INTO the user-supplied buffer, ..."

I have a series of patches that should address the deadlock issue,
that I'll be sending out shortly.

						- Ted
