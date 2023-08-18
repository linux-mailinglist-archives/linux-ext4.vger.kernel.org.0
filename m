Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25076780558
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 07:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357962AbjHRFGX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 01:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357970AbjHRFFy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 01:05:54 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5576435BD
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 22:05:53 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37I55Dlm026890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 01:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692335116; bh=pIbqOeSF9GC+neATBAN631zVJ3AdYx0rrIBABcd53UA=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=U/VihsXeuTthstVUa0/wMQ1FCqFOjP8MOD8Aek4Mw3uKCPPANt/jhpBsQa1Oh/4lh
         S11M7aVSQ9PgzY0H0AhrUM0Y+ZxU8K6O9njOlFjF0ckY8z6Z4DfS7d2pqb+NAZF9aZ
         xrjnhI4v0ZyDW/6PHU1OILchhQOlQ9QgGceJZQcDBoIOEy/EVoA1kexMrTHQ3BZsqn
         AYCOdJjnNtJc298oXpAmQk/+KgCyjgmnomssrf19mkt705EQ8z9wIf2RquHaqiTk1u
         YuPTGaqgIxwY6y2VdRE819GawxeSOfJ0ZzZt52HkslWIo8Xh/aTbHpJ0LhfkQlAkPd
         jQU2jV0a8GUig==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3093615C0502; Fri, 18 Aug 2023 01:05:13 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, Cai Xinchen <caixinchen1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH -next] ext4: remove unused function declaration
Date:   Fri, 18 Aug 2023 01:05:07 -0400
Message-Id: <169233503390.3504102.11388108431125257654.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230802030025.173148-1-caixinchen1@huawei.com>
References: <20230802030025.173148-1-caixinchen1@huawei.com>
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


On Wed, 02 Aug 2023 03:00:25 +0000, Cai Xinchen wrote:
> These functions do not have its function implementation.
> So those function declaration is useless. Remove these
> 
> 

Applied, thanks!

[1/1] ext4: remove unused function declaration
      commit: 7677d5947b80d028f55e1e3a5855b2bb1e504b5c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
