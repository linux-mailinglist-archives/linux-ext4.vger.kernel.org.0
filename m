Return-Path: <linux-ext4+bounces-7822-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E135AB4DC2
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 10:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300993A83C6
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 08:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140AF1F76C2;
	Tue, 13 May 2025 08:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALiCic0S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE81F153A;
	Tue, 13 May 2025 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747123998; cv=none; b=hz0vX4vNlCaJWB7k0w0Nmxj6YnsJGfOKH6uyALH8lByNVvQF1Cjr+Q5NWYpNMFT9HZPV+4/Px3Ul7xhycNsSW0z1CWU3p6gmCfJj47peLGs0dlTW0EgZ9fn34UQjwXFHaeWUgQq22Aa/bZy2KbqY8jqBBdgy9qAY0G4it86SGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747123998; c=relaxed/simple;
	bh=VjGUdYqj+Qc34YVyRojxlp4/hRzSU7HXnHeT7tefCw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c76Rmtj4+USOyObfiazQ2olRfNxKXEVSbyQ/rH2CkA8l6sJnYHtoXGw5IlIMLqjmUJJkA4Kstm0yqE5YzVTHD/TJhwo+lLbY9GIF7kMLlmqjxF/Ci88gUl4v2JCikXUaDoWlWfMD7gS/A2fmEutvpTcTdWr4AhwbxbF2iv1eXCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALiCic0S; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22e45088d6eso67967625ad.0;
        Tue, 13 May 2025 01:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747123994; x=1747728794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cERww6XP6YlenzBbutvOpJSWb6p0QGeO0bWaCu0oTLA=;
        b=ALiCic0SV+RnRfzwcx+J6Vg6lAWdTK4oG/86XhmTke7OfV0QU33anC3wvqFvo3uWGA
         lbCjf7t8fxay40nys3P/rEo8+K6zmBO2MkkpVoIZheg1dJ6NCi/74k4USy0Z5w1ahbLr
         OXR2EMtIhOkdgEr/sN382xjVC2rDENh9OA5H9100uK2qy28xQsymBeo3b+WwoSGyDsyR
         pw+h/dqha0jdDDZgh8rf7AsnB6YuiVD5zJ04OeqNLuz+MYXu4mIY9nJZLakik2AoPbno
         UNODu+GQgYZ7NQqnhRdLdBVslWfXjfyH0h518q20WNvM5qM/VmUjJcwyAASbZxeXjR7/
         7GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747123994; x=1747728794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cERww6XP6YlenzBbutvOpJSWb6p0QGeO0bWaCu0oTLA=;
        b=J53Ioo6T4k8HrZRK+nWcL7wBOhVO/mkLWzIH/muOcgzqYWQDeHCj9ODt3tQz9x/CHC
         SHyY/hv8xK66hUPsZ82fZyfrV6GcGF8/swRWbo8mS9jN+CntUNIH9rFgUAG5qR8gMYNv
         kz2oCC5VdQV62ea6mK/ytGIn5nhKLiHiCwnvnoENq4Qnu9YL8DCHjEmHxgyb8OVdCK49
         LBhAYjgPO+VOrv1h+bndQKrfxhKuhqKqh0v+cbUPJobhIkdU/yjHnFuEwjetR4Sf+pUQ
         W/RCyJzFwso1tDmcBUZah9wQsucCh3QEM7yEaJwgXMboXuNFOWgzEtVQd42h+Tkm0rQn
         wbTA==
X-Forwarded-Encrypted: i=1; AJvYcCXQbpZfTvpazHIFh/1+dEub3u407TO/fZbA8Rih5FqZcz7WYONXaK7jONz9V3mkGjf4BnCTJM3JGH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5gq5obue3Dv9Spqv7Kh5Mn2oX0Oc/03ymwbbnqsC2aVbq396q
	P8sMpdVhNoiH2lsvG9SeaExcwEeufAsmUUoOPkiWWPCrrfifuuaV3NrdXA==
X-Gm-Gg: ASbGnctXBW2RfUdXlUeNoqjbW5C2ashZdJRcyGnp2W7oIpXmrAH6wMnG4P2CGdOmHU5
	5jswS45Y4YQcvhxtZNLZvGCpteHmOsl08rqr7p6FYELbxo/L6zlUNUJeRqdr31iIfb7b13A4LdS
	38Fxj5jRFAyElsb/14lG34aUdI9f7EEpYcXpTHpuIHr5iPUvOMncr/zo8i9ozAwgVIlLWAt/EpX
	FSYlTW4OPI1Zk6piMxnmNIBE5AdBl5J63nHYTMwoTnsWbWEqNHJ7jxy0+nrUwvurQ3qE5psikMJ
	A+Rga1KA0mrM6dOyfmVFJeYpvNLb/ogwuJHuHecm+vEM31sEEvrADxI=
X-Google-Smtp-Source: AGHT+IE53A6lPhldTdCa5mmpTipHheDTwex2Bmymq7XyEcx5l4bCaV730M3PyXqzj9GrC8sjD7EAFQ==
X-Received: by 2002:a17:902:c94f:b0:21f:35fd:1b7b with SMTP id d9443c01a7336-22fc919e93emr218159035ad.50.1747123983283;
        Tue, 13 May 2025 01:13:03 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc75450b6sm75896585ad.49.2025.05.13.01.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 01:13:02 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	david@fromorbit.com,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v1 1/3] new: Add a new parameter (name/emailid) in the "new" script
Date: Tue, 13 May 2025 08:10:10 +0000
Message-Id: <837f220a24b8cbaaaeb2bc91287f2d7db930001a.1747123422.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747123422.git.nirjhar.roy.lists@gmail.com>
References: <cover.1747123422.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch another optional interactive prompt to enter the
author name and email id for each new test file that is
created using the "new" file.

The sample output looks like something like the following:

./new selftest
Next test id is 007
Append a name to the ID? Test name will be 007-$name. y,[n]:
Creating test file '007'
Add to group(s) [auto] (separate by space, ? for list): selftest quick
Enter <author_name> <email-id>: Nirjhar Roy <nirjhar.roy.lists@gmail.com>
Creating skeletal script for you to edit ...
 done.

...
...

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 new | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/new b/new
index 6b50ffed..139715bf 100755
--- a/new
+++ b/new
@@ -136,6 +136,9 @@ else
 	check_groups "${new_groups[@]}" || exit 1
 fi
 
+read -p "Enter <author_name> <email-id>: " -r
+author_name="${REPLY:=YOUR NAME HERE}"
+
 echo -n "Creating skeletal script for you to edit ..."
 
 year=`date +%Y`
@@ -143,7 +146,7 @@ year=`date +%Y`
 cat <<End-of-File >$tdir/$id
 #! /bin/bash
 # SPDX-License-Identifier: GPL-2.0
-# Copyright (c) $year YOUR NAME HERE.  All Rights Reserved.
+# Copyright (c) $year $author_name.  All Rights Reserved.
 #
 # FS QA Test $id
 #
-- 
2.34.1


