Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748973EBA60
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Aug 2021 18:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbhHMQu3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Aug 2021 12:50:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44372 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236813AbhHMQu1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Aug 2021 12:50:27 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17DGnrsi025190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 12:49:54 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7650B15C37C1; Fri, 13 Aug 2021 12:49:53 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] tests: check quota file space usage does not get accounted
Date:   Fri, 13 Aug 2021 12:49:51 -0400
Message-Id: <162886682604.316310.8444293605338818617.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210804121652.25833-1-jack@suse.cz>
References: <20210804121652.25833-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 4 Aug 2021 14:16:52 +0200, Jan Kara wrote:
> Check that space used by quota files themselves does not get accounted
> into the space tracked by quota subsystem.

Applied, thanks!

[1/1] tests: check quota file space usage does not get accounted
      commit: 958b95eb0b37de5e3a52cb7abbfdfeed79635727

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
