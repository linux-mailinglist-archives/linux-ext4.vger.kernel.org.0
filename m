Return-Path: <linux-ext4+bounces-4122-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD435975E95
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Sep 2024 03:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97203281E21
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Sep 2024 01:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8902837B;
	Thu, 12 Sep 2024 01:40:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.revreso.de (mail.revreso.de [185.170.112.15])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C1F1D545
	for <linux-ext4@vger.kernel.org>; Thu, 12 Sep 2024 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.170.112.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726105205; cv=none; b=VP+XDcOuAnupYKjGnZqnv7tMLr/nsXSCQjUK87/+GTsiCWF32fFHJ40IbNe9/cZYuCaUzF+/beVNzbhlWc5H5F912RCSnJjdNVgUpLTUVUty4XE7JwQWQIbPl9ZlSSI5AkOvRqwrAJKR10vy5Epo02xH2PeuqJPYg/pvVOxV7Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726105205; c=relaxed/simple;
	bh=uyvjzyMTeo4AarOkJ5JLXI7qcdgQKn/1679taLSw2l4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P69hOQjEdBm+UkXeiI8DhA8dSlDSUj8Uw9yzuwUttadjPLbp5VkNfJvXxuLdCa2enoU9kgdxAWbXFKx4jQ1U4YcKzHXl0RttIi4lpoPbgNJ8q2Jx/IbJxnn23J0Xo0HDfxLpe7JOkU6CizhbDgTDEKoFxhxpk+xjLfXOyF/61Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inbox.aber.nicht.jetzt; spf=fail smtp.mailfrom=inbox.aber.nicht.jetzt; arc=none smtp.client-ip=185.170.112.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inbox.aber.nicht.jetzt
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=inbox.aber.nicht.jetzt
Date: Thu, 12 Sep 2024 03:33:36 +0200
From: Fabian Pack <projekte.linux.ext4@inbox.aber.nicht.jetzt>
To: linux-ext4@vger.kernel.org
Subject: has_casefold_inode() checks free inodes
Message-ID: <3jdnbhtxrihgnsqyaotqudefedwzmg2ha4fba72cj2s2ddyr4v@mc2pamq6cnys>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=gigadoc2@revreso.de smtp.mailfrom=projekte.linux.ext4@inbox.aber.nicht.jetzt

Hi,
I found out that current tune2fs won't let me remove the casefold flag 
from a filesystem where it was once used, even after deleting all 
directories using the flag. A community debugging session later it seems 
to me that has_casefold_inode() in tune2fs.c will not only check used 
inodes but free ones as well, so it refuses because casefolded 
directories were present in the past and their inodes have not yet been 
reused.

Is this intentional or did we find a bug?

Best regards,
Fabian

