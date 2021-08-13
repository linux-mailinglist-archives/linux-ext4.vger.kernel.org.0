Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407CB3EBA73
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Aug 2021 18:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbhHMQxg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Aug 2021 12:53:36 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44822 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234887AbhHMQxP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Aug 2021 12:53:15 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17DGqh6q026074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 12:52:44 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C0C3F15C37C1; Fri, 13 Aug 2021 12:52:43 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] e2fsck: Make sure quota files are not referenced from dirs
Date:   Fri, 13 Aug 2021 12:52:37 -0400
Message-Id: <162887354773.348309.12455265756686895929.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210812133216.26539-1-jack@suse.cz>
References: <20210812133216.26539-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 12 Aug 2021 15:32:16 +0200, Jan Kara wrote:
> Quota files must not be referenced from directory entries. Otherwise
> they can get corrupted under the hands of the kernel.
> 
> 
> 
> 

Applied, thanks!

[1/1] e2fsck: Make sure quota files are not referenced from dirs
      (no commit info)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
