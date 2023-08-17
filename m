Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565F077F832
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Aug 2023 15:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbjHQN6r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Aug 2023 09:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351700AbjHQN6l (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Aug 2023 09:58:41 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2779F2D71
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 06:58:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37HDwK2Q014905
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 09:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692280702; bh=AueFLCI/dYPlx5hHmJno8//6FIyvyvJ3360BaxS/v3E=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=VB/HdIykyP8Jj4U9KRqcjtvxWDnhBUCBrDAQJUcQ7f+dQrqpvE9EeZ2G+AOSQYzdJ
         cQ6yJby25uFR8DfQc7e1IAbu7Cen5/5NkMRFig+4zFmdM7MiQBSeg3N66SLz9w1dJk
         Rd3sTE5STEDbyeSNPs9Jfw23KltqIt6loG/NtMdaIlgAdAbxPQ/4KEus+CNxhMte+t
         59AUWFqjpSwewkPcxZCSH0WA8GBSO8enF8nLIvg5EdZba/6O2zTGXplhwth5Rjqnil
         72Mv1cmjkugu/N5CYvG0foWRPG3qBulH/v4vuSFotIrvjWv0ugExI1F47QY0oRWMC4
         S/ZELPWgKAMnw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9F9DB15C0501; Thu, 17 Aug 2023 09:58:20 -0400 (EDT)
Date:   Thu, 17 Aug 2023 09:58:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] ext4: correct return value of ext4_convert_meta_bg
Message-ID: <20230817135820.GX2247938@mit.edu>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-4-shikemeng@huaweicloud.com>
 <20230816030044.GI2247938@mit.edu>
 <a7ea5edb-834d-091a-efe6-7d15a5a55338@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7ea5edb-834d-091a-efe6-7d15a5a55338@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 17, 2023 at 10:48:51AM +0800, Kemeng Shi wrote:
> 
> > errout:
> > 	ret = ext4_journal_stop(handle);
> > 	if (!err)
> > 		ret = err;
> > 	return ret;
> > 
> I think you mean:
> errout:
> 	ret = ext4_journal_stop(handle);
> 	if (*err*)
> 		ret = err;
> 	return ret;
> And I will fix in this way if I don't get wrong.

Yes, that's what I meant.  Another way of putting it might be:

	ret = ext4_journal_stop(handle);
	return (err ? err : ret);

				- Ted
