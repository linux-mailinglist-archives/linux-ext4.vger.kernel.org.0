Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CC547E580
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Dec 2021 16:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbhLWPgr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Dec 2021 10:36:47 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33567 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232417AbhLWPgr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Dec 2021 10:36:47 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BNFahvH032356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 10:36:44 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7F36215C00C8; Thu, 23 Dec 2021 10:36:43 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/2] ext4: remove lazytime/nolazytime mount options handled by MS_LAZYTIME
Date:   Thu, 23 Dec 2021 10:36:39 -0500
Message-Id: <164027376767.2884327.15583563759797199280.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211222104517.11187-1-lczerner@redhat.com>
References: <20211222104517.11187-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 22 Dec 2021 11:45:16 +0100, Lukas Czerner wrote:
> The lazytime and nolazytime mount options were added temporarily back in
> 2015 with commit a26f49926da9 ("ext4: add optimization for the lazytime
> mount option"). It think it has been enough time for the util-linux with
> lazytime support to get widely used. Remove the mount options.
> 
> 

Applied, thanks!

[1/2] ext4: remove lazytime/nolazytime mount options handled by MS_LAZYTIME
      commit: 4437992be7ca3ac5dd0a62cad10357112d4fb43e
[2/2] ext4: fix i_version handling on remount
      commit: 960e0ab63b2e5d8476bc873743f812e9e90cd047

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
