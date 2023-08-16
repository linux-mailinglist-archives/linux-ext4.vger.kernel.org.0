Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5BC77D8E3
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 05:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbjHPDOt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 23:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241523AbjHPDOs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 23:14:48 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8312C1FCA
        for <linux-ext4@vger.kernel.org>; Tue, 15 Aug 2023 20:14:46 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-114-154.bstnma.fios.verizon.net [173.48.114.154])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37G3EW02007491
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 23:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692155674; bh=Zvm8xzvIrkJbvE2V52Dp//4CRiIInMEHWAIMuWaeBb8=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=PSRUsdoIvNCVI7gMeQ++2FtQ80xX6W9bGE/liYAIgnysC8LEaLRtrHlh47qxOCOol
         mAfU0+J5Gsn2jkrrnev9euGZaoUGGCzSrYrl2b00OGj3aqWu4kfjUl71yd8RDI9b25
         hbleBJnTF5Vv6OgTL1Yw1SrfGDMK/LfzwSx/w0M+KA6fIdMxdxbJusM28B3wZ8K9H7
         YalSdA47nPPbpz9pxHP0FWB5t8zo/2M+ve4cObZFz6ylc9m0oyijzW4ryulCu+Igp1
         dWUlUSRQLxKwc96LYIl7iZrt/o0GPOiCU9E7gkaUuSwXxZ1f/lxyN7ha9WcRX81xD0
         aHpblpVlp4RvQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5F5A715C0292; Tue, 15 Aug 2023 23:14:32 -0400 (EDT)
Date:   Tue, 15 Aug 2023 23:14:32 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] ext4: remove commented code in reserve_backup_gdb
Message-ID: <20230816031432.GO2247938@mit.edu>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-8-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629120044.1261968-8-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 29, 2023 at 08:00:38PM +0800, Kemeng Shi wrote:
> Remove commented code in reserve_backup_gdb
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
