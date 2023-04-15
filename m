Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461C56E2E87
	for <lists+linux-ext4@lfdr.de>; Sat, 15 Apr 2023 04:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjDOCPY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Apr 2023 22:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDOCPX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 Apr 2023 22:15:23 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3734559D
        for <linux-ext4@vger.kernel.org>; Fri, 14 Apr 2023 19:15:21 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33F2F3iA016799
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 22:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1681524904; bh=wCNIpWM7nogR/mSYpT0UxzyiGyDlHt2BywHG2gFoqjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=JAW9EwmsW85EJk5DK0Jo4tzzZ3H2VOLCENffACk3ni8xYRz+dGodLMSwAO5XItIXn
         AQTihu0SXlU61RcDEyRKKjOATSZlyzwgCt/16mXV2ZnnRdsjLvgyc6EoFKMZBEavjP
         Of3x5WqPu6iUYDncY+vLvTbuiRd+oZd4JEVQP924ro72fWo68NmOo0S/tqT7LYdhom
         VADNedTIc/a7J034xVz7ofn39FzxLG/nI2M2EUJbGPvb7U8GKnYNvo8R/kOD3fwkxc
         rnIwKVZRW/0/2AWihgTV9s/wpUp+CaMcEcy0/pglN9X4w5kCBa/17RZYHDq90EN/fo
         PNDvBRbe5xYgQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E078915C4935; Fri, 14 Apr 2023 22:15:02 -0400 (EDT)
Date:   Fri, 14 Apr 2023 22:15:02 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 0/2] ext4: Fix two bugs in journalled writepages rework
Message-ID: <20230415021502.GC301301@mit.edu>
References: <20230323145102.3042-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323145102.3042-1-jack@suse.cz>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 23, 2023 at 03:53:57PM +0100, Jan Kara wrote:
> Hello!
> 
> These two patches fix two problems introduced by the rewrite of journalled
> writeback path.

I've folded these patches into the "ext4: Covert data=journal
writeback to use ext4_writepages()" commit in my tree.  Thanks,

	     	 		    	      - Ted

