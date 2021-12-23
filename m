Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E26047E581
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Dec 2021 16:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348979AbhLWPgt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Dec 2021 10:36:49 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33575 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232417AbhLWPgt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Dec 2021 10:36:49 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BNFaioj032367
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 10:36:45 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8B52315C339C; Thu, 23 Dec 2021 10:36:44 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] ext4: don't fail remount if journalling mode didn't change
Date:   Thu, 23 Dec 2021 10:36:40 -0500
Message-Id: <164027376767.2884327.6991498448246875005.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211220152657.101599-1-lczerner@redhat.com>
References: <20211220152657.101599-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 20 Dec 2021 16:26:57 +0100, Lukas Czerner wrote:
> Switching to the new mount api introduced inconsistency in how the
> journalling mode mount option (data=) is handled during a remount.
> 
> Ext4 always prevented changing the journalling mode during the remount,
> however the new code always fails the remount when the journalling mode
> is specified, even if it remains unchanged. Fix it.
> 
> [...]

Applied, thanks!

[1/1] ext4: don't fail remount if journalling mode didn't change
      commit: 4c2467287779f744cdd70c8ec70903034d6584f0

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
