Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA3E78110F
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 18:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378850AbjHRQ4j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 12:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378841AbjHRQ4R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 12:56:17 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6D23AAA
        for <linux-ext4@vger.kernel.org>; Fri, 18 Aug 2023 09:56:16 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-121-162.bstnma.fios.verizon.net [173.48.121.162])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37IGteY6026542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 12:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692377743; bh=aEFI5NCvVqF8X+8DPqJaOjC6g1n4TPE2RFzA16MMATg=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=HbdAVGSW+NC5xO7/JcenEiBn7j+1ccr3mkJJtyPqQ9+bbSSTfPMCnJq08oraMKSt/
         5Q4uCSMSavL7IDFqaTNjyG671yBmT4Ku2NeMxHcnwaLkc4rVNE9pk/8EjLQftvU0Go
         jCzIIO2UbXjWgU6EynT+qcZ0l7kJbAGwvUplRLgTDD75TNRdv0c/lcEkwVsfyGfzzG
         XMfjlCPzdRu+/gInzoBqgDeJzWYOsEqpLt8N/Uj22vPrTLc08xija4OsSzYWYWj5Bi
         F380O3YPpiDAT8Xg/cEE3LIJSfqG2veV104rX8kwtaLYAVPcud907UOYkQiHEtfpE/
         8NM7tJjAZZPZA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7B65415C0501; Fri, 18 Aug 2023 12:55:40 -0400 (EDT)
Date:   Fri, 18 Aug 2023 12:55:40 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Fengnan Chang <changfengnan@bytedance.com>
Cc:     adilger.kernel@dilger.ca, guoqing.jiang@linux.dev,
        linux-ext4@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [External] Re: [PATCH v3] ext4: improve trim efficiency
Message-ID: <20230818165540.GC3515079@mit.edu>
References: <20230725121848.26865-1-changfengnan@bytedance.com>
 <20230818034330.GE3464136@mit.edu>
 <CAPFOzZvwvSioyiCW8K7sDpzB7Grq==5-9i-wODGKw0E_4DFaPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPFOzZvwvSioyiCW8K7sDpzB7Grq==5-9i-wODGKw0E_4DFaPQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 18, 2023 at 03:14:34PM +0800, Fengnan Chang wrote:
> If we move the allocation and initialization the ext4_free_data
> structure to ext4_try_to_trim_range, we need move
> ext4_lock_group too, because we can't do alloc memory when
> hold lock in ioctl context.
> How about just remove ext4_trim_extent, and do all work in
> ext4_try_to_trim_range?  it will be easier to read.

Yes, agreed.

					- Ted
