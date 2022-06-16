Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA2054E568
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jun 2022 16:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376998AbiFPOyU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jun 2022 10:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbiFPOyS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jun 2022 10:54:18 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73B72871D;
        Thu, 16 Jun 2022 07:54:17 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25GErbDi018617
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 10:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1655391219; bh=HmH8IW6dn33l6vgkuo6oly3cpMBiSZ/+CfDPyI0x6ws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IVV9MY4wQsuPv74KdJASggDXZ0V2e667MKTsIIJKBCi8PO68jXPIFUSZIpV6URaHo
         VKDxusEjLFatWUJl5jd7KN3zKUfQ8ASmTmncALHprzBc/nXR1iIySVcFsT4PQg1mVm
         zTUTTZhG6B2IgM6mhEAEp5CAOPAWfO8Ge4g6mm8TE6jK76vPIlPC9LHVKVu+raajQA
         pzpWi20dpNouHJFM+2uXD9TBld4yNbFjL7H6v+apUHGoE/83PMheUFek+txIXLZB9b
         lDLbDQmOfTOeZZiI/z56vwUUY4HWKp04F0r0CiMDwpSQO4p5bE8CnU8FWUGqVC3nPF
         Yv/m9LB6zCOhw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 91AEA15C3F35; Thu, 16 Jun 2022 10:53:37 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, jack@suse.com
Subject: Re: [PATCH -next] fs: Fix jbd2_journal_try_to_free_buffers() kernel-doc comment
Date:   Thu, 16 Jun 2022 10:53:36 -0400
Message-Id: <165539120793.59826.15576791047345383049.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220512075432.31763-1-yang.lee@linux.alibaba.com>
References: <20220512075432.31763-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 12 May 2022 15:54:32 +0800, Yang Li wrote:
> Add the description of @folio and remove @page in function kernel-doc
> comment to remove warnings found by running scripts/kernel-doc, which
> is caused by using 'make W=1'.
> 
> fs/jbd2/transaction.c:2149: warning: Function parameter or member
> 'folio' not described in 'jbd2_journal_try_to_free_buffers'
> fs/jbd2/transaction.c:2149: warning: Excess function parameter 'page'
> description in 'jbd2_journal_try_to_free_buffers'
> 
> [...]

Applied, thanks!

[1/1] fs: Fix jbd2_journal_try_to_free_buffers() kernel-doc comment
      commit: 4f5bf12732fd78e225fc62b7c5c84d9032f8048a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
