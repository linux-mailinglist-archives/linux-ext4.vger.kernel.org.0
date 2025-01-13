Return-Path: <linux-ext4+bounces-6065-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2931A0BDE7
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 17:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFEB516987C
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 16:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF89124023A;
	Mon, 13 Jan 2025 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psIre6d+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D431C5D77;
	Mon, 13 Jan 2025 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786800; cv=none; b=FnBZd8RWBXQTcF5C+LVARp5IeaeNlsen2ZFBn0KY+4ygEn+ghqxWn7yTITb6CG7D4rd+TQ1fbs6bJ5NrcV7PO+gm71OoqJ/X1glrS6JhMs/bC1ydVfAFF34l94I7W3h9nEiTZzwgyfDfmBpPYZbkX7MGuNzuAvs7J1FHS+TG50Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786800; c=relaxed/simple;
	bh=C9lMucOWh0XimSzmt2LW/VyG4a2Sh5b0vKWYIvIsKcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2Y8wgSsz+Gko03jhzavTQN9khGjaO699yfKcfeUNNighpb7ZxkDlckSXlQ90eMy5Zwc0aPGa55zHwlyRQ2W9k31VbCnMas1gGroyb7iCTEQEEHopY4VeWeNbd+ZFLUsNp1BpxVavtqz/nly9czhXnXb+fRVGJuNNqlR3kikfRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psIre6d+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EACC4CED6;
	Mon, 13 Jan 2025 16:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736786800;
	bh=C9lMucOWh0XimSzmt2LW/VyG4a2Sh5b0vKWYIvIsKcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psIre6d+DRxw9yWUOuZ5hYpJXVXOURaqzHKBWvp9anosxTzPvfTZ88jAHAUyeCvFa
	 6+eVt3sF0/F4s/1MWOyKEbnvCcf6snqHIVUQO1uvuJMN8gq1nbvjXnjiawN9ezVuWg
	 C/AuDfMHUkoSWZ3qnDeT2m55yIq4g75mdFhCg5Gl9PubWuujA1nKETkiFUIZ3ko/UJ
	 IYOJBIHHoVutccBKExo4nRnAdAs2jzkqMXOns97xpvG5ojZp4HXRrXy9RlMlgPl/km
	 YzHEC+ISW2nzvgSEl90ObcUZGh6/C0AEBT8yc/VNmzdfofNIXdHlvkXSMZ11QEcVNH
	 xkxtaorJJXkNg==
Date: Mon, 13 Jan 2025 08:46:39 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [RFC 1/5] tests/selftest: Add a new pseudo flaky test.
Message-ID: <20250113164639.GG1251194@frogsfrogsfrogs>
References: <cover.1736496620.git.nirjhar.roy.lists@gmail.com>
 <03ba6c154c9e2cf3d68131b3af2ca12b96663d25.1736496620.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03ba6c154c9e2cf3d68131b3af2ca12b96663d25.1736496620.git.nirjhar.roy.lists@gmail.com>

On Fri, Jan 10, 2025 at 09:10:25AM +0000, Nirjhar Roy (IBM) wrote:
> This test is to simulate the behavior of a flaky test. This will be required
> when we will make some modifications to the pass/fail metric calculation of
> the test infrastructure where we will need a test with non-zero pass
> and non-zero failure rate.
> 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  tests/selftest/007     | 21 +++++++++++++++++++++
>  tests/selftest/007.out |  2 ++
>  2 files changed, 23 insertions(+)
>  create mode 100755 tests/selftest/007
>  create mode 100644 tests/selftest/007.out
> 
> diff --git a/tests/selftest/007 b/tests/selftest/007
> new file mode 100755
> index 00000000..f100ec5f
> --- /dev/null
> +++ b/tests/selftest/007
> @@ -0,0 +1,21 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 IBM Corporation.  All Rights Reserved.
> +# Author: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> +#
> +# FS QA Test 007
> +#
> +# This test is to simulate the behavior of a flakey test.
> +#
> +
> +. ./common/preamble
> +_begin_fstest selftest
> +
> +if (($RANDOM % 2)); then
> +    echo "Silence is golden"
> +else
> +    echo "Silence is flakey"

Oh is it now? ;)

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +fi
> +
> +status=0
> +exit
> diff --git a/tests/selftest/007.out b/tests/selftest/007.out
> new file mode 100644
> index 00000000..fd3590e6
> --- /dev/null
> +++ b/tests/selftest/007.out
> @@ -0,0 +1,2 @@
> +QA output created by 007
> +Silence is golden
> -- 
> 2.34.1
> 
> 

