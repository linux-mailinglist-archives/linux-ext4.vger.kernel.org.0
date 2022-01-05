Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8692E484CF6
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jan 2022 04:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbiAEDyK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jan 2022 22:54:10 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50353 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230284AbiAEDyK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jan 2022 22:54:10 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2053rtZU011325
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jan 2022 22:53:55 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 002D515C00E1; Tue,  4 Jan 2022 22:53:54 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger@dilger.ca,
        Laurent GUERBY <laurent@guerby.net>
Subject: Re: [PATCH v3 2/2] ext4: Allow to change s_last_trim_minblks via sysfs
Date:   Tue,  4 Jan 2022 22:53:53 -0500
Message-Id: <164135481976.265171.17012583253406040752.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211103145122.17338-2-lczerner@redhat.com>
References: <20211103145122.17338-1-lczerner@redhat.com> <20211103145122.17338-2-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 3 Nov 2021 15:51:22 +0100, Lukas Czerner wrote:
> Ext4 has an optimization mechanism for batched disacrd (FITRIM) that
> should help speed up subsequent calls of FITRIM ioctl by skipping the
> groups that were previously trimmed. However because the FITRIM allows
> to set the minimum size of an extent to trim, ext4 stores the last
> minimum extent size and only avoids trimming the group if it was
> previously trimmed with minimum extent size equal to, or smaller than
> the current call.
> 
> [...]

Applied, thanks!

[2/2] ext4: Allow to change s_last_trim_minblks via sysfs
      commit: db19c4cdc28a8ec1241d50656991ab1bd96f5c02

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
