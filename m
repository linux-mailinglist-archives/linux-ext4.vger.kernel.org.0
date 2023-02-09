Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DA6690DBA
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Feb 2023 16:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBIP5a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Feb 2023 10:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjBIP53 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Feb 2023 10:57:29 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2212C670
        for <linux-ext4@vger.kernel.org>; Thu,  9 Feb 2023 07:57:28 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 319Fuq0h019612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Feb 2023 10:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1675958214; bh=or7EpFxIpSIU1N7C+m8fzV0exEm1a8ruCKHXenTJQU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AnzoNwIwBfyaH7K03UGOwuJ15brSEJ43sGYumLqpjMZ23rM4h5tGIWYr41mi5yQtJ
         lRjShhuDbcLQGuak9stFTtFbSWSPJg35SNXbqzSuaZf4srfqb/udJVgImFALjmcFlJ
         X1iBm/aYKdIWORcxpVST5cLUdRKoiXymiF39UQ3tO3+/SfKS0/ptO7CAXjpl7LuYZ0
         /qp2OqoJ4QLMjE1vDdqzPxtgu83ibymyyD9QRciLM09AZlCyY28P6QcMoC4ldbJOnJ
         aWOyLWRUe9tUV6oKYECKYXByRqP55Qo89zE9TfLeUwCe0Tcdq4PQjHvXgxpcIIW/We
         UoH0RDbBeU9RQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id F394515C340F; Thu,  9 Feb 2023 10:56:51 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] ext4: use ext4_fc_tl_mem in fast-commit replay path
Date:   Thu,  9 Feb 2023 10:56:48 -0500
Message-Id: <167595818785.2451331.14863312824605865865.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221217050212.150665-1-ebiggers@kernel.org>
References: <20221217050212.150665-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 16 Dec 2022 21:02:12 -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> To avoid 'sparse' warnings about missing endianness conversions, don't
> store native endianness values into struct ext4_fc_tl.  Instead, use a
> separate struct type, ext4_fc_tl_mem.
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: use ext4_fc_tl_mem in fast-commit replay path
      commit: 11768cfd98136dd8399480c60b7a5d3d3c7b109b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
