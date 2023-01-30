Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295F6680569
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jan 2023 06:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjA3FIt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Jan 2023 00:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjA3FIt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Jan 2023 00:08:49 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA37618D
        for <linux-ext4@vger.kernel.org>; Sun, 29 Jan 2023 21:08:47 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30U58eWM018394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 00:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1675055321; bh=HvPrvZt7NeduuEd3LgGIG5qPKW/C7ac33B8iw9gJDQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=hs1hBj659xcpatOyM0A0tELHt73xbGxKzeu1wqANxEsDRtR3f8PjD+yRECkJgdoiq
         TrfViWi7GTPAE3aAO9nhoSMvSiLv1J2G35flRJF8kuJBlLaN+bC5v1bCUtB6yGdgkQ
         nmkkexKdRwUn7260GfI6OSwM0dpoCjyDqsQvAa5oEJDgs1o3SNaWTU4jeScPoQ+LlJ
         apD2qG7opuCeaaiC/CH47gCF9FemXQDyi5oRsoFTCTEGz6R0P5vh5f39oO7bvlP3gO
         dTkGlpKUIn2Hw3CVdmGUVxWda5m+vbgL2IxBdKmS/fRCiz1vr5/thnbK+3f8nAQqSD
         UidPj9Y7itj9w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 641B515C3589; Mon, 30 Jan 2023 00:08:40 -0500 (EST)
Date:   Mon, 30 Jan 2023 00:08:40 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/4] debugfs: fix a -Wformat warning in dump_journal()
Message-ID: <Y9dQ2Kbm3hniTqph@mit.edu>
References: <20230128224651.59593-1-ebiggers@kernel.org>
 <20230128224651.59593-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128224651.59593-3-ebiggers@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jan 28, 2023 at 02:46:49PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> This really should just use PRIi64, but e2fsprogs doesn't use the
> inttypes.h format specifiers elsewhere, so just be consistent for now.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, I have this in my tree already (but I just hadn't pushed it
out yet; I wanted to get some other fixes done on the maint branch
before I merged maint with the master/next branches.)

       	 	      	       		   - Ted
