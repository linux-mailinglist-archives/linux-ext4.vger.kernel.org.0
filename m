Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D5D40C2C9
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Sep 2021 11:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhIOJbi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Sep 2021 05:31:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48008 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhIOJbi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Sep 2021 05:31:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D4B8C2217E;
        Wed, 15 Sep 2021 09:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631698218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KBXvP/tQY/6YNmXTomYXQTROGX/Wda2pygcza9I7f28=;
        b=DYDP1vXrqMo+oODc6fJidUHC826vyBE2rJFrc6i2pQ944mq4ec8ieu2PcUruvvhHQS2Ybe
        xTjowqxJtHOUqKniuQpHgKVtQMy9dVMXIAbltcuRSp/wpKNHzgILDgvAJeee+SpBuRXxhF
        KGTX0CR2UgBF1wLuK5D3kDMrWM2esOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631698218;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KBXvP/tQY/6YNmXTomYXQTROGX/Wda2pygcza9I7f28=;
        b=eiw7XkM3RyREt3GyMG60rb37wi6eas0H+EzqhZ5IaJSzSzVfXEghbpSKE2JI89DUoVanUP
        F8YAPKDBOiR2lIBQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id C8663A3B94;
        Wed, 15 Sep 2021 09:30:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A51D21E4318; Wed, 15 Sep 2021 11:30:18 +0200 (CEST)
Date:   Wed, 15 Sep 2021 11:30:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/8 v2] Quota fixes for e2fsprogs
Message-ID: <20210915093018.GA10055@quack2.suse.cz>
References: <20210823154128.16615-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823154128.16615-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Ted!

Ping? What about these fixes?

								Honza

On Mon 23-08-21 17:41:20, Jan Kara wrote:
> Hello,
> 
> here is next revision of my quota fixes for e2fsprogs. When addressing the
> e2fsck regression Ted has pointed out, I've noticed another serious bug in
> e2fsck support for quotas where it just nukes existing quota limits when
> replaying orphan list. A fix is now included in this series together with
> expanded test to catch the problem.
> 
> Changes since v1:
> * Rename the functions so that names match functionality
> * Fix e2fsck regression when processing orphan list
> * Fix e2fsck bug to preserve quota limits over orphan processing
> * Expand test to verify quota limits are properly preserved
> * Fix quota output headings in debugfs
> 
> 								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
