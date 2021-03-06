package dcsc.mvc.domain.coupon;

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

import dcsc.mvc.domain.classes.Book;
import dcsc.mvc.domain.user.Student;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Entity
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class IssueCoupon {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "issue_no_seq")
	@SequenceGenerator(sequenceName = "issue_no_seq",allocationSize = 1,name = "issue_no_seq")
	private Long issueNo;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "student_id")
	@JsonIgnore
	private Student student;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "coupon_id")
	@JsonIgnore
	private Coupon coupon;
	
	@CreationTimestamp
	private LocalDateTime issueStartDate;
	private LocalDateTime issueEndDate;
	
	private String issueUsable;
	
}