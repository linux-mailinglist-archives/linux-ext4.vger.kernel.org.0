Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084CD77F99F
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Aug 2023 16:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352257AbjHQOsv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Aug 2023 10:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352294AbjHQOs1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Aug 2023 10:48:27 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E1E2D7D
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 07:48:10 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37HEltoa012292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 10:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692283676; bh=UsueoxVdJSJznvjwpjWS/rQ6dS+XyfwsPbldjps5BT0=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=h3oX0Sez9CDt1XIUumsTrqyr6lUgeUgo8BM2Wt6534LJVy724UmC5nqZjcv0wsMvm
         mhX9RS+je2PuX/AyqlIcoWBa4wquWG4xWrEvQybqWiw7hu3nCADHmIR/lP+3jtdWxY
         Rvu/BrtiG1pkMnD/Hx1xZDMZFZ/e1rkz4MIUQWU+7uEnwpRXe9Q555kXEzyYGIJ+E+
         olOI1lbOcFWyxyMQvJ7OiPmzat82G3vCE3SGLfWZZmq1xGIDiDWsJNDpt472OrDqmk
         442v7oIaErAsSKvwVerbwDvRI6Mm58+FDYabRp6qIreoJjbCpZ0jPIY821AdmsIoVT
         24Nldbrx9wgGw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2539615C0501; Thu, 17 Aug 2023 10:47:55 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Eric Whitney <enwlinux@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] e2fsprogs: modify dumpe2fs to report free block ranges for bigalloc
Date:   Thu, 17 Aug 2023 10:47:52 -0400
Message-Id: <169228359791.3428939.11893985617025273328.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230721185506.1020225-1-enwlinux@gmail.com>
References: <20230721185506.1020225-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Fri, 21 Jul 2023 14:55:06 -0400, Eric Whitney wrote:
> dumpe2fs has never been modified to correctly report block ranges
> corresponding to free clusters in block allocation bitmaps from bigalloc
> file systems.  Rather than reporting block ranges covering all the
> blocks in free clusters found in a block bitmap, it either reports just
> the first block number in a cluster for a single free cluster, or a
> range beginning with the first block number in the first cluster in a
> series of free clusters, and ending with the first block number in the
> last cluster in that series.
> 
> [...]

Applied, thanks!

[1/1] e2fsprogs: modify dumpe2fs to report free block ranges for bigalloc
      commit: b9df2bcb4d8a4d2f3985f3d2f9d85292b826cc8b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
