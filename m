Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817AD77FD09
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Aug 2023 19:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353982AbjHQRb5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Aug 2023 13:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354023AbjHQRbq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Aug 2023 13:31:46 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BCABF
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 10:31:45 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37HHVOhr000772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 13:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692293488; bh=7OPHFNtxsAD0FSGa58gtrNAoBUca7TOB2rkoM8RFaSI=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=QOyNGP+nkvZpbDAnxlplZxb2x5YDcPHizlaqqWwybOQdK1BD2A0RvbyAfEX/BbUTH
         EZdVowAV5YJgecH3/pAin6Eyhyi6F8nKiGjEcio40OvruTKY9C+WkFjmaGIz9TxiTf
         Ag33hXXklQ8SGW5waX57SNp1mM76Jt2hgkbPPXB7L6NRvAz1Z2Bs1MuruiQLbWvoYd
         cX+RzMsd2J6jfNvkXGwpVtKLzNN23Sgv5O1L8Ash/zPrvdcf+SL4ZlR5cEEmhRxSLC
         QXJHlfUIcjQvAwpUfFN4y6peM1HvapGaMIEXp8FFQbp2Ny0Fj58oXFA0pKJpDbcFgP
         OtofTxAk0nc8g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CB1FB15C0501; Thu, 17 Aug 2023 13:31:23 -0400 (EDT)
Date:   Thu, 17 Aug 2023 13:31:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     zhangshida <starzhangzsd@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhangshida@kylinos.cn,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH] ext4: Modify the rec_len helpers to accommodate future
 cases
Message-ID: <20230817173123.GD2247938@mit.edu>
References: <20230807012654.55951-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807012654.55951-1-zhangshida@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 07, 2023 at 09:26:54AM +0800, zhangshida wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> Following Andreas' suggestion, it is time to adapt these helpers
> to handle larger records during runtime, especially in preparation
> for the eventual support of ext4 with a block size greater than
> PAGE_SIZE.

Is there a reason for landing this now?  We don't have support for
block_size > PAGE_SIZE yet, and this patch doesn't come for free, at
least not systems with page_size < 64k.  These inline functions are
*very* hot and get used in a large number of places.  Have you looked
to see what it might do to text size of the ext4 code?  And whether
the expansion to the icache might actually impact performance on CPU
bound workloads with very large directories?

I will note that there are some opportunities to optimize how often we
use ext4_rec_len_from_disk.  For example, it gets called from
ext4_check_dir_entry(), and often the callers of that function will
need the directory record length.  So having ext4_check_dir_entry()
optionally fill in the rec_len via a passed-in pointer might be
worthwhile.

Cheers,

						- Ted
