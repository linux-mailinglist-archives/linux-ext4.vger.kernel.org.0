Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B966430C622
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Feb 2021 17:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbhBBQjd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Feb 2021 11:39:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236396AbhBBQjI (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 2 Feb 2021 11:39:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84DB664F77;
        Tue,  2 Feb 2021 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612283907;
        bh=G/jzrNPOsaqA4CNP1xzN0d2XeYmKgsXMjxYOtQs+1eg=;
        h=Date:From:To:Cc:Subject:From;
        b=nBCTJABz6ug1qHNzkOE6kfQGsIknV1FSBo+LanlXbJRq/W9OpEZcaiS0T6NtWkaM6
         SddnCcTcZTDLEn3GKSb/aKXi5LJptPX5EQBGPpEQOUC+9/Nys5pJsvDBp7N5aONHxc
         i1MCKG/7HRYMs2Q5qKi8KQcPljd/qg1qQ80z1VpGbS0KaIYsmwc3guY2d2c8Fsz+WB
         9NxCiObrGUsuHLJ/d2IejRRGM6D95VpPjahdZUda+B9OGCpezp8P4FXz7x1kXncI9i
         DuHekGJ5eVSMHoRtE2Nko1RzOZv7juiz8lsv+dL7UOO3mvWV/m0CQwBG8rAl72tuEk
         4pOyFMmvIIkxQ==
Date:   Tue, 2 Feb 2021 08:38:27 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
Subject: e2fsprogs 1.45.7 & 1.46.0?
Message-ID: <20210202163827.GA7186@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

So... I see in the e2fsprogs git repo that the release notes and
version.h that the maint branch is now at  1.45.7 and master is at
1.46.0.  There's a tag for 1.45.7 but no tag for 1.46.0.

Are those releases official, and did I miss the announcement on the
list?

--D
