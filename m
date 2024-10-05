Return-Path: <linux-ext4+bounces-4513-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2E09913F6
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Oct 2024 04:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92E3284C04
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Oct 2024 02:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34B51B960;
	Sat,  5 Oct 2024 02:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="HY9KT7Oz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705EF179A7
	for <linux-ext4@vger.kernel.org>; Sat,  5 Oct 2024 02:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728096078; cv=none; b=lyX/aX/5pmdev+TV/Rp3gJhA2zxeQqDotqChSVcGpbByyYG5b2Bko76mcDXFMkWNZ7bsy7KE6kcj7P62iNBe2H4tvwIJYO+DwPZZMIx+pgmyL2Cmi3GjG+1dpz25v/pROWsbW2tY2w+qX25PHb87XfMOyRjAhc6dHNIsBPyjYM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728096078; c=relaxed/simple;
	bh=rgcvqJmvlH2HTN0zFOurrYY5awS8sGnj3wX0Z34vcWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tkdOxQxs+NjE4o36Z3PrwNMCqjt2X8lMjraZ0YODy0F9rKIT/zKUokjmoYq5wDR7M8Wspn913x6bIPE/fT2d0L0xQnKiX2TAb56SFZ2v52w1Afu2w5K8fu3DAyz5Ynoyj5Ec4Qkg9eAn/kWFPlV+v6Hzt7naO/U0KUR1kynorx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=HY9KT7Oz; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-178.bstnma.fios.verizon.net [173.48.111.178])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4952emfO023986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 22:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1728096051; bh=HgoS6w9iZheywTQuRarrQ3Om+NyxbEPt9uNcTL4/8sg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=HY9KT7OzJ8BFnb9FH3x1iqVXDgX9F3hR4itJzPKn3mlWbRg9rULrAwMOiomsgpLZ4
	 LDlWjy5AxjtW7BJJqp6PWZ66jSns1hqb+QqQu8rna/K0vrU3aHFT+IwQQ3TQlGWPe3
	 /cBBiI+z4kE9wptusjzu4d7BCDVfGBVDT8GZfaY9flrJCC7Uoe3ocPlUsHqOgliQRJ
	 eXUzogcRpIcCOVqIcxX8dxl4UQQnH6k+hhBJXaAV25y/1eHxl7sOw60AqPy2jVtkyr
	 JNoxylMEERwRlnlkZCMtSvUB+48EQSOOsW3tfmMbL4m04oMm8k2G2kptYbYjbusWmS
	 gqyuySN1qjibQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 87BBE15C666A; Fri, 04 Oct 2024 22:40:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ext4: mark FC as ineligible using an handle
Date: Fri,  4 Oct 2024 22:40:37 -0400
Message-ID: <172809600229.505638.17144963244444341318.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923104909.18342-1-luis.henriques@linux.dev>
References: <20240923104909.18342-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 23 Sep 2024 11:49:07 +0100, Luis Henriques (SUSE) wrote:
> Changes since v1:
> * only the second patch has been changed to drop the call to
>   ext4_fc_mark_ineligible() in the error path.  Commit text has also been
>   adjusted accordingly.
> 
> And here's the original cover-letter:
> 
> [...]

Applied, thanks!

[1/2] ext4: use handle to mark fc as ineligible in __track_dentry_update()
      commit: faab35a0370fd6e0821c7a8dd213492946fc776f
[2/2] ext4: mark fc as ineligible using an handle in ext4_xattr_set()
      commit: 04e6ce8f06d161399e5afde3df5dcfa9455b4952

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

