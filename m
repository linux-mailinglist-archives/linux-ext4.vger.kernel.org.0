Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 282AD1AA06
	for <lists+linux-ext4@lfdr.de>; Sun, 12 May 2019 04:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfELCiZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 11 May 2019 22:38:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37358 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfELCiZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 11 May 2019 22:38:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 14A53278253
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] libext2fs: add missing check for utf8lookup()'s return value
Organization: Collabora
References: <20190510182053.23819-1-tytso@mit.edu>
Date:   Sat, 11 May 2019 22:38:20 -0400
In-Reply-To: <20190510182053.23819-1-tytso@mit.edu> (Theodore Ts'o's message
        of "Fri, 10 May 2019 14:20:53 -0400")
Message-ID: <85ef54e6sj.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> Fixes-Coverity-Bug: 1442630
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  lib/ext2fs/nls_utf8.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

We should get this applied on the kernel side as well.

Thanks,


-- 
Gabriel Krisman Bertazi
