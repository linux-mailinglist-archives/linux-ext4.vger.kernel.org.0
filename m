Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2912954E559
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jun 2022 16:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbiFPOuI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jun 2022 10:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiFPOuH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jun 2022 10:50:07 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2167731534;
        Thu, 16 Jun 2022 07:50:04 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25GEnrsL016481
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 10:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1655390995; bh=AVh4XvYQgeUERqts3Qq/5UwLQw/hh9wtP74QW3XmZKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Gn+9OAGD5U6vwbsonNj42JgJv3+w1/saL1GZGw3RFdeO0HDWuz9GZamMayVO8D41c
         kQPtt2zj58qE4K7+GCAeYyVHsUe/CIopa7X1r8t8GKIe0N7V/SfoRiXy8/FMqw6QvB
         bSMwak0hgCPRxVz0UwSgTdPgJWLSHGkd1L18A+Pbp3aQ76klsyok8Xp0F0ejxu66oY
         jf/XivjW4425AzubT2LYK59Rki8u8vTjyN2916Qq7OTFHlYw2X06QdwOwGvcWtfwrQ
         h7aghvqeXRPZauJ1Cgkmd+p0m4jLPw65lWqU0QyxYThgFkhwJg/9+KUe83DuC316mT
         nAHIpCNU4RWXw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6137E15C3F35; Thu, 16 Jun 2022 10:49:53 -0400 (EDT)
Date:   Thu, 16 Jun 2022 10:49:53 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Liu Peibao <liupeibao@163.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4: page-io: use 'unsigned int' to bare use of
 'unsigned'
Message-ID: <YqtDEfJd5uUxucaS@mit.edu>
References: <20220518120137.2544-1-liupeibao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518120137.2544-1-liupeibao@163.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 18, 2022 at 08:01:36PM +0800, Liu Peibao wrote:
> Fix warnings by checkpatch.
> 
> Signed-off-by: Liu Peibao <liupeibao@163.com>

Please don't send checkpatch-only patches.

Thanks,

						- Ted
