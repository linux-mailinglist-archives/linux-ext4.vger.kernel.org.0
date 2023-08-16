Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEB677D943
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 05:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbjHPDtI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 23:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241708AbjHPDsm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 23:48:42 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E949269F
        for <linux-ext4@vger.kernel.org>; Tue, 15 Aug 2023 20:48:41 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-114-154.bstnma.fios.verizon.net [173.48.114.154])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37G3mSDu021439
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 23:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692157710; bh=hUzwQJl5RN4rIkMyxl8oq92C3HzQoNiR3B7m+Aaaryc=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=L+AJ09/JC7WlGrvti1dXRf02zqahyEfLPPr7CkaXNBSGlTbpd5BQjKBUDXGnTW/Uz
         8aPR/rH1QkBz3DFn0RZ5GDZZ5AuYON7ghq9LRqCIFtmwwc0bGnTC0WjS+B3iWb+pva
         Q7qLce/aF/nKRfEwGwGA5ICrg0AT5P8vQxJNk/fOEmoWV3gWYnDAeBtYNgj8mwynrx
         yuPCAOFuKPJ+VqbEXXviXfgM3w5uH5kKNL/m80dhu6OfDYA1QUtRadPaV+CzKJOvYB
         kJ5JA54qyHBBZCm+VIh4oP/Yw8c/C7CjpqTO2rytspeXrkvpprii7BvpqRqRu4wNtg
         kLg4Ml9pcbysQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3E83515C0292; Tue, 15 Aug 2023 23:48:28 -0400 (EDT)
Date:   Tue, 15 Aug 2023 23:48:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] ext4: remove unnecessary initialization of count2
 in set_flexbg_block_bitmap
Message-ID: <20230816034828.GU2247938@mit.edu>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-14-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629120044.1261968-14-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 29, 2023 at 08:00:44PM +0800, Kemeng Shi wrote:
> We always overwrite count2 to "EXT4_CLUSTERS_PER_GROUP(sb) -
> (first_cluster - start)" after its initialization in for loop
> initialization statement .
> Just remove unnecessary initialization of count2.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
