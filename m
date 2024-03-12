Return-Path: <linux-ext4+bounces-1605-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A360187965A
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Mar 2024 15:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D411F213CE
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Mar 2024 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F3877655;
	Tue, 12 Mar 2024 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EA45PRW0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23027AE51;
	Tue, 12 Mar 2024 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253748; cv=none; b=m+ZAv+mEtEsQXm10a/tgbEjiEVNdu/0PLN66TWGqPKCxYd4ruQumLGGr7NKQZxCRgR/tB6PzzV+/MJwvp5KgOWXvqu/3Sjn0EsSZfsKnQsRx6Y18Nytegxs+glaq/34OHSuDO8R/UQkmMt7IkhbJgB7ddxxxyH2Zd6Ewt8ViQDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253748; c=relaxed/simple;
	bh=YSIzAEOxvxB8VGNd/9Gww9F6GQ70E0UmyZYJIqPU7xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8UpHbIexxgXyt1BQvGfMC05vVYf1aRXBjMtmm/2l7KPaEo36yIzttj+H0rXyZYeJ8nFG2x3q/o4govITfb9FDDb2H4YZMYQu5Ec+fzQjxUSZWVE2+2Gb60uVkJlJL4dEs28TlOGVhNjrmzUMrnEitd/43uqBGek/Hz7ABOG+s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EA45PRW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A59C433C7;
	Tue, 12 Mar 2024 14:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710253748;
	bh=YSIzAEOxvxB8VGNd/9Gww9F6GQ70E0UmyZYJIqPU7xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EA45PRW0whCcEeWaee4KU806em3InvFrAFbRUcCrvLIUt/xQniqvZYkfU9BAkl5Rr
	 JIr5XZfESu/ZBSFH1GkWUxoCcGLvaMaeSJM19NXFHVx4Tnl0Wg3r1iQjJHR9zxt79/
	 NLbKHiPnMku19IlBP7fErxG6kEgkqr37/OqZPc88n+QCKA/+KR8FR8bEHBvGQDxRx/
	 gEXEZJ3uOUyiss4FARAw10LH6VrH654ixXc18gMrPg0qapyjttsuySJCZqLkAjhKV0
	 iqQ9gV4WvVkd6aV+dXIafLHslRScZi3vTiUie3MS6MXJOWtK70FofcOakb/iQK5WbF
	 CTBcwaET8cJyQ==
From: Christian Brauner <brauner@kernel.org>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] fs_parser: move fsparam_string_empty() helper into header
Date: Tue, 12 Mar 2024 15:28:51 +0100
Message-ID: <20240312-monieren-wallung-9c0559b4bdaa@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312104757.27333-1-luis.henriques@linux.dev>
References: <20240312104757.27333-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025; i=brauner@kernel.org; h=from:subject:message-id; bh=YSIzAEOxvxB8VGNd/9Gww9F6GQ70E0UmyZYJIqPU7xo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR+SFtjselouoter9Hb0j9dUhyLV6xTnSTUbn755Qmpi npGodxnHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOJLWX4H72taPIt3Qls/aKX g1tcc8QOfLj+4e+8NuMOHV72o9uPCzEyfLj3ly1/Z+ey1X8vufZ+/H2CO3W625T/EzmWbwvf1pB /iQ8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 12 Mar 2024 10:47:57 +0000, Luis Henriques (SUSE) wrote:
> Since both ext4 and overlayfs define the same macro to specify string
> parameters that may allow empty values, define it in an header file so
> that this helper can be shared.
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs_parser: move fsparam_string_empty() helper into header
      https://git.kernel.org/vfs/vfs/c/39c99a820c4a

