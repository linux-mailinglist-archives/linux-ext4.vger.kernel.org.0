Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9C942CB4E
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Oct 2021 22:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhJMUsZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Oct 2021 16:48:25 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59844 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229496AbhJMUsZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Oct 2021 16:48:25 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19DKkIL7003446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 16:46:18 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2E1F015C00CA; Wed, 13 Oct 2021 16:46:18 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] Revert "ext4: enforce buffer head state assertion in ext4_da_map_blocks"
Date:   Wed, 13 Oct 2021 16:46:14 -0400
Message-Id: <163415796177.214938.9752602885736039327.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211012171901.5352-1-enwlinux@gmail.com>
References: <20211012171901.5352-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 12 Oct 2021 13:19:01 -0400, Eric Whitney wrote:
> This reverts commit 948ca5f30e1df0c11eb5b0f410b9ceb97fa77ad9.
> 
> Two crash reports from users running variations on 5.15-rc4 kernels
> suggest that it is premature to enforce the state assertion in the
> original commit.  Both crashes were triggered by BUG calls in that
> code, indicating that under some rare circumstance the buffer head
> state did not match a delayed allocated block at the time the
> block was written out.  No reproducer is available.  Resolving this
> problem will require more time than remains in the current release
> cycle, so reverting the original patch for the time being is necessary
> to avoid any instability it may cause.
> 
> [...]

Applied, thanks!

[1/1] Revert "ext4: enforce buffer head state assertion in ext4_da_map_blocks"
      commit: 52264b162a51eadb0adcb55297cf91905c6ede98

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
